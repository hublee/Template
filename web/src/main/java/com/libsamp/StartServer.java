package com.libsamp;

import org.eclipse.jetty.server.Server;
import org.eclipse.jetty.webapp.WebAppContext;

/**
 * Created by hlib on 2016/3/12 0012.
 */
public class StartServer {


    public static void main(String[] args) throws Exception {
        Server server = new Server(9998);

        WebAppContext context = new WebAppContext();
        context.setContextPath("/");
        context.setDescriptor("D:\\code lib\\Template\\web\\src\\main\\webapp\\WEB-INF\\web.xml");
        context.setResourceBase("D:\\code lib\\Template\\web\\src\\main\\resources");
        context.setWar("D:\\code lib\\Template\\web\\target\\web.war");
        context.setParentLoaderPriority(true);
        server.setHandler(context);
        server.start();
        server.join();


        /*WebAppContext context = new WebAppContext();
        context.setContextPath("/");
        String ProPath= System.getProperty("user.dir");
        System.out.println("项目目录："+ProPath);
        context.setDescriptor(ProPath + "/web/src/main/webapp/WEB-INF/web.xml");
        context.setResourceBase(ProPath + "/web/src/main/webapp");
        context.setParentLoaderPriority(true);
        server.setHandler(context);
        server.start();
        server.join();*/
    }

}
