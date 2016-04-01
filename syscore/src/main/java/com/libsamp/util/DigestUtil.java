package com.libsamp.util;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.shiro.crypto.hash.Sha384Hash;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;
import javax.crypto.spec.SecretKeySpec;
import java.io.File;
import java.io.FileInputStream;
import java.security.SecureRandom;

/**
 * Created by hlib on 2015/8/13 0013.
 * 加密工具类
 */
public class DigestUtil {

    //sha384加密
    public static String encryptBySha384(String data) {
        String sha384Hex = new Sha384Hash(data).toBase64();
        return sha384Hex;
    }

    //des对称加密
    public byte[] encryptByDes(byte[] data) {
        try {
            byte[] key = "11111111".getBytes();

            // DES算法要求有一个可信任的随机数源

            SecureRandom sr = new SecureRandom();

            // 从原始密钥数据创建DESKeySpec对象
            DESKeySpec dks = new DESKeySpec(key);

            // 创建一个密匙工厂，然后用它把DESKeySpec转换成

            // 一个SecretKey对象

            SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");

            SecretKey secretKey = keyFactory.generateSecret(dks);

            // using DES in ECB mode

            Cipher cipher = Cipher.getInstance("DES/ECB/PKCS5Padding");

            // 用密匙初始化Cipher对象

            cipher.init(Cipher.ENCRYPT_MODE, secretKey, sr);

            // 执行加密操作

            byte encryptedData[] = cipher.doFinal(data);

            return encryptedData;

        } catch (Exception e) {
            System.err.println("DES算法，加密数据出错!");
            e.printStackTrace();
        }
        return null;
    }

    public static byte[] desCrypto(byte[] datasource, String password) {
        try{
            SecureRandom random = new SecureRandom();
            DESKeySpec desKey = new DESKeySpec(password.getBytes());
            //创建一个密匙工厂，然后用它把DESKeySpec转换成
            SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
            SecretKey securekey = keyFactory.generateSecret(desKey);
            //Cipher对象实际完成加密操作
            Cipher cipher = Cipher.getInstance("DES");
            //用密匙初始化Cipher对象
            cipher.init(Cipher.ENCRYPT_MODE, securekey, random);
            //现在，获取数据并加密
            //正式执行加密操作
            return cipher.doFinal(datasource);
        }catch(Throwable e){
            e.printStackTrace();
        }
        return null;
    }

    private static byte[] decrypt(byte[] src, String password) throws Exception {
        // DES算法要求有一个可信任的随机数源
        SecureRandom random = new SecureRandom();
        // 创建一个DESKeySpec对象
        DESKeySpec desKey = new DESKeySpec(password.getBytes());
        // 创建一个密匙工厂
        SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
        // 将DESKeySpec对象转换成SecretKey对象
        SecretKey securekey = keyFactory.generateSecret(desKey);
        // Cipher对象实际完成解密操作
        Cipher cipher = Cipher.getInstance("DES");
        // 用密匙初始化Cipher对象
        cipher.init(Cipher.DECRYPT_MODE, securekey, random);
        // 真正开始解密操作
        return cipher.doFinal(src);
    }

    /**
     * 加密
     *
     * @param content 需要加密的内容
     * @param password  加密密码
     * @return
     */
    public static byte[] aesEncrypt(String content, String password) {
        try {
            KeyGenerator kgen = KeyGenerator.getInstance("AES");
            kgen.init(128, new SecureRandom(password.getBytes()));
            SecretKey secretKey = kgen.generateKey();
            byte[] enCodeFormat = secretKey.getEncoded();
            SecretKeySpec key = new SecretKeySpec(enCodeFormat, "AES");
            Cipher cipher = Cipher.getInstance("AES");// 创建密码器
            byte[] byteContent = content.getBytes("utf-8");
            cipher.init(Cipher.ENCRYPT_MODE, key);// 初始化
            byte[] result = cipher.doFinal(byteContent);
            return result; // 加密
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 加密
     *
     * @param content 需要加密的内容
     * @param password  加密密码
     * @return
     */
    public static String aesEncrypt2Str(String content, String password) {
        try {
            byte[] encryptResult = aesEncrypt(content, password);
            return parseByte2HexStr(encryptResult);// 加密
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 加密
     *
     * @param content 需要解密的内容
     * @param password  加密密码
     * @return
     */
    public static String aesDecrypt2Str(String content, String password) {
        try {
            byte[] decryptFrom = parseHexStr2Byte(content);
            byte[] decryptResult = aesDecrypt(decryptFrom, password);//解码
            return new String(decryptResult);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**解密
     * @param content  待解密内容
     * @param password 解密密钥
     * @return
     */
    public static byte[] aesDecrypt(byte[] content, String password) {
        try {
            KeyGenerator kgen = KeyGenerator.getInstance("AES");
            kgen.init(128, new SecureRandom(password.getBytes()));
            SecretKey secretKey = kgen.generateKey();
            byte[] enCodeFormat = secretKey.getEncoded();
            SecretKeySpec key = new SecretKeySpec(enCodeFormat, "AES");
            Cipher cipher = Cipher.getInstance("AES");// 创建密码器
            cipher.init(Cipher.DECRYPT_MODE, key);// 初始化
            byte[] result = cipher.doFinal(content);
            return result; // 加密
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static String parseByte2HexStr(byte buf[]){
        StringBuffer sb = new StringBuffer();
        for(int i = 0; i < buf.length; i++){
            String hex = Integer.toHexString(buf[i] & 0xFF);
            if (hex.length() == 1) {
                hex = '0' + hex;
            }
            sb.append(hex.toUpperCase());
        }
        return sb.toString();
    }

    /**
     * 将16进制转换为二进制
     * @method parseHexStr2Byte
     * @param hexStr
     * @return
     * @throws
     * @since v1.0
     */
    public static byte[] parseHexStr2Byte(String hexStr){
        if(hexStr.length() < 1)
            return null;
        byte[] result = new byte[hexStr.length()/2];
        for (int i = 0;i< hexStr.length()/2; i++) {
            int high = Integer.parseInt(hexStr.substring(i*2, i*2+1), 16);
            int low = Integer.parseInt(hexStr.substring(i*2+1, i*2+2), 16);
            result[i] = (byte) (high * 16 + low);
        }
        return result;
    }

    /**
     * 文件地址
     * @param url
     * @return
     */
    public static String getFileMd5(String url) throws Exception {
        FileInputStream fis = new FileInputStream(new File(url));
        return DigestUtils.md5Hex(fis);
    }

    public static void main(String[] args){

        String content = "hlb 321 "+System.currentTimeMillis();
        String password = "1234567890";

        System.out.println("加密前---.>" + content);
        String c1 = aesEncrypt2Str(content,password);
        System.out.println("加密后---》》 " + c1);

        System.out.println("解密后-->> " +  aesDecrypt2Str(c1,password));

        /*//待加密内容
        String str = "hlb-321-2015.09.01";
        //密码，长度要是8的倍数
        String password = "123456789";
        byte[] result = desCrypto(str.getBytes(), password);
        System.out.println("加密后内容为："+new String(result));

        //直接将如上内容解密
        try {
            byte[] decryResult = decrypt(result, password);
            System.out.println("加密后内容为："+new String(decryResult));
        } catch (Exception e1) {
            e1.printStackTrace();
        }*/

    }


}
