package com.libsamp.service.impl;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.libsamp.annotation.Logable;
import com.libsamp.dto.StatusDTO;
import com.libsamp.entity.Attachment;
import com.libsamp.mapper.AttachmentMapper;
import com.libsamp.service.AttachmentService;
import com.libsamp.util.Constants;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.*;
import java.util.*;
import java.util.List;

/**
 * Created by hlib on 2015/8/14 0014.
 */
@Service("attachmentService") @Transactional(readOnly = true)
public class AttachmentServiceImpl extends BaseServiceImpl<AttachmentMapper,Attachment> implements AttachmentService {

    @Autowired
    public void setMapper(AttachmentMapper mapper) {
        this.mapper = mapper;
        this.busName = "附件";
    }

    @Override @Transactional(readOnly = false) @Logable(option = "上传")
    public Attachment upload(HttpServletRequest request,String dest) throws IOException {
        CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(request.getServletContext());
        Attachment attachment = null;
        if(multipartResolver.isMultipart(request)){
            MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
            //取得request中的所有文件名
            Iterator<String> iter = multiRequest.getFileNames();
            while(iter.hasNext()){
                //取得上传文件
                MultipartFile file = multiRequest.getFile(iter.next());
                if(file != null){  //由前端控一次只能上传一个文件
                    attachment = new Attachment();
                    //取得当前上传文件的文件名称
                    String myFileName = file.getOriginalFilename();
                    //如果名称不为“”,说明该文件存在，否则说明该文件不存在
                    if(StringUtils.isNoneBlank(myFileName)){
                        String suffix = myFileName.substring(myFileName.lastIndexOf("."));
                        //重命名上传后的文件名
                        String fileName = UUID.randomUUID().toString() + suffix;
                        //定义上传路径
                        String uri = dest + fileName;
                        File localFile = new File(Constants.UPLOAD_URI + uri);
                        if(!localFile.getParentFile().exists()){
                            localFile.getParentFile().mkdirs();
                        }
                        localFile.createNewFile();

                        file.transferTo(localFile);
                        attachment.setName(myFileName);
                        attachment.setSize(localFile.length());
                        attachment.setUri(uri);
                        attachment.setUid(fileName);
                        attachment.setSuffix(suffix);
                        Image image = ImageIO.read(localFile);
                        if(null != image){ //如果是图片文件 则保存长度和宽度
                            BufferedImage bi = ImageIO.read(new FileInputStream(localFile));
                            Map<String,Object> mp = new HashMap<>();
                            mp.put("width",bi.getWidth());
                            mp.put("height",bi.getHeight());
                            ObjectMapper om = new ObjectMapper();
                            String privateAttr = om.writeValueAsString(mp);
                            attachment.setPrivateAttr(privateAttr);
                        }

                    }
                }
            }
        }
        return attachment;
    }

    @Override @Logable(option = "客户端上传")
    public List<Attachment> appUpload(HttpServletRequest request, String dest) throws IOException {
        CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(request.getServletContext());
        List<Attachment> attachments = new ArrayList<>();
        if(multipartResolver.isMultipart(request)){
            MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
            //取得request中的所有文件名
            Iterator<String> iter = multiRequest.getFileNames();
            Attachment attachment;
            while(iter.hasNext()){
                //取得上传文件
                MultipartFile file = multiRequest.getFile(iter.next());
                if(file != null){  //由前端控一次只能上传一个文件
                    attachment = new Attachment();
                    //取得当前上传文件的文件名称
                    String myFileName = file.getOriginalFilename();
                    //如果名称不为“”,说明该文件存在，否则说明该文件不存在
                    if(StringUtils.isNoneBlank(myFileName)){
                        String suffix = myFileName.substring(myFileName.lastIndexOf("."));
                        //重命名上传后的文件名
                        String fileName = UUID.randomUUID().toString() + suffix;
                        //定义上传路径
                        String uri = dest + fileName;
                        File localFile = new File(Constants.UPLOAD_URI + uri);
                        if(!localFile.getParentFile().exists()){
                            localFile.getParentFile().mkdirs();
                        }
                        localFile.createNewFile();

                        file.transferTo(localFile);
                        attachment.setName(myFileName);
                        attachment.setSize(file.getSize());
                        attachment.setUri(uri);
                        attachment.setUid(fileName);
                        attachment.setSuffix(suffix);
                        attachments.add(attachment);
                    }
                }
            }
        }
        return attachments;
    }

    @Override @Transactional(readOnly = false) @Logable(option = "下载")
    public void downLoad(Integer id, HttpServletResponse response) throws IOException {
        Attachment attachment = getById(id);
        if(null == attachment || StringUtils.isBlank(attachment.getUri())) throw new FileNotFoundException("文件不存在");
        String uri = Constants.UPLOAD_URI.concat(attachment.getUri());
        InputStream is = new FileInputStream(uri);
        response.reset();
        response.setHeader("Content-Disposition", "attachment;filename=" + attachment.getName());
        OutputStream os = response.getOutputStream();
        byte[] content = new byte[1024];
        int len;
        while((len = is.read(content)) != -1){
            os.write(content,0,len);
        }
        os.flush();
        os.close();
        //更新下载次数
        attachment.setDownCount(null == attachment.getDownCount()?1:attachment.getDownCount()+1);
        try{
            modify(attachment);
        }catch(Exception e){
            log.error("更新下载次数出错",e);
        }
    }

    @Override
    public Map<Integer, List<Attachment>> getAttachMap(List<Integer> sourceIds, String entity) {
        Attachment param = new Attachment();
        param.setSourceIds(sourceIds);
        param.setSourceEntity(entity);
        List<Attachment> attachments = getList(param);
        Map<Integer,List<Attachment>> attachMap = new HashMap<>();

        if(null != attachments && attachments.size() > 0){
            for(Attachment att : attachments){
                if(!attachMap.containsKey(att.getSourceId())){
                    attachMap.put(att.getSourceId(),new ArrayList<Attachment>());
                }
                attachMap.get(att.getSourceId()).add(att);
            }
        }
        return attachMap;
    }

    @Override
    public Map<String, String> getAbsolutePath(HttpServletRequest request, String dest) throws IOException {
        CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(request.getServletContext());
        Map<String,String> pathMap = new HashMap<>();
        if(multipartResolver.isMultipart(request)){
            MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
            //取得request中的所有文件名
            Iterator<String> iter = multiRequest.getFileNames();
            String fileIptName = "";
            String reqUrl;
            while(iter.hasNext()){
                //取得上传文件
                fileIptName = iter.next();
                MultipartFile file = multiRequest.getFile(fileIptName);
                if(file != null){  //由前端控一次只能上传一个文件
                    //取得当前上传文件的文件名称
                    String myFileName = file.getOriginalFilename();
                    //如果名称不为“”,说明该文件存在，否则说明该文件不存在
                    if(StringUtils.isNoneBlank(myFileName)){
                        String suffix = myFileName.substring(myFileName.lastIndexOf("."));
                        //重命名上传后的文件名
                        String fileName = UUID.randomUUID().toString() + suffix;
                        //定义上传路径
                        String uri = dest + fileName;
                        File localFile = new File(Constants.UPLOAD_URI + uri);
                        if(!localFile.getParentFile().exists()){
                            localFile.getParentFile().mkdirs();
                        }
                        localFile.createNewFile();
                        file.transferTo(localFile);
                        reqUrl = request.getRequestURL().toString();
                        pathMap.put(fileIptName, reqUrl.substring(0,reqUrl.indexOf(request.getRequestURI())) + Constants.UPLOAD_URI + uri);
                    }
                }
            }
        }
        return pathMap;
    }

    @Override
    public String parseEvalHtml(Attachment htmlFile) throws IOException {
        StringBuffer htmlStr = new StringBuffer();
        InputStreamReader isr = new InputStreamReader(new FileInputStream(new File(Constants.UPLOAD_URI + htmlFile.getUri())),"gbk");
        BufferedReader br = new BufferedReader(isr);
        String line;
        while ((line = br.readLine()) != null){
//            htmlStr += htmlStr + line;
            htmlStr.append(line);
        }
        br.close();
        if(htmlStr.indexOf("img") <= 0) return null;
        String bodyStr = htmlStr.substring(htmlStr.indexOf("<body"),htmlStr.lastIndexOf("</body>")+7);
        bodyStr = bodyStr.replace("</body>","");
        String bodyBeginTag = bodyStr.substring(0,bodyStr.indexOf(">")+1);
        bodyStr = bodyStr.replace(bodyBeginTag,""); //去掉<body>标签
        bodyStr = bodyStr.replaceAll("<img","<input type=file ").replaceAll("src","name");

        StringBuffer rtStr = new StringBuffer("<iframe name=\"frm\" style=\"visibility:hidden;width:10px;height:5px;\"></iframe>");
        rtStr.append("<form id=\"htmlForm\" action=\"/editor/evaluate/page/uploadHtmlInnerFile\" method=\"post\" enctype=\"multipart/form-data\" target=\"frm\" >");
        rtStr.append("<input type=\"hidden\" id=\"htmlId\" name=\"htmlId\" value=\""+htmlFile.getId()+"\"/>");
        rtStr.append(bodyStr);
        rtStr.append("<div style=\"text-align:center;\"><input style=\"width:120px;height:30px\" type=\"submit\" onclick=\"this.value='正在上传...';this.disabled='disabled'\" value=\"保存页面文件\"/></div></form>");
        return rtStr.toString();
    }

    @Override
    public StatusDTO modifyHtmlSrcPath(Integer htmlId, Map<String, String> pathMap) {
        BufferedReader reader = null;
        BufferedWriter writer = null;
        try {
            Attachment attach = getById(htmlId);
            //先读取文件内容
            File file = new File(Constants.UPLOAD_URI + attach.getUri());
            if(!(file.isFile() && file.exists())) return new StatusDTO(Boolean.FALSE);
            InputStreamReader isr = new InputStreamReader(new FileInputStream(file),"gbk");
            reader = new BufferedReader(isr);
            String line;
            StringBuffer htmlStr = new StringBuffer();
            while ((line = reader.readLine()) != null){
                htmlStr.append(line);
            }
            //替换相对路径为绝对路径
            String newHtml = htmlStr.toString();
            for(Map.Entry<String,String> entry : pathMap.entrySet()){
                newHtml = newHtml.replace(entry.getKey(), entry.getValue());
            }
            reader.close();

            //再覆盖修改源文件
            OutputStreamWriter osw = new OutputStreamWriter(new FileOutputStream(file),"gbk");
            writer = new BufferedWriter(osw);
            writer.write(newHtml);
            writer.close();

            return new StatusDTO(Boolean.TRUE);
        }catch (Exception e){
            e.printStackTrace();
            return new StatusDTO(Boolean.FALSE);
        }finally {
            try {
                if(null != reader) reader.close();
                if(null != writer) writer.close();
            }catch (Exception e1){
                e1.printStackTrace();
            }
        }
    }
}
