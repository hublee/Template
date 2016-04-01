package com.libsamp.util;

import javax.net.ssl.*;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.security.SecureRandom;
import java.security.cert.X509Certificate;

/**
 * Created by hlib on 2015/9/16 0016.
 */
public class HttpUtil {

    public static String doGetByHttps(String addr){
        HttpsURLConnection conn = null;
        StringBuffer stb = new StringBuffer();
        try {
            // Create a trust manager that does not validate certificate chains
            TrustManager[] trustAllCerts = new TrustManager[] { new
                    X509TrustManager() {
                        public X509Certificate[] getAcceptedIssuers() {
                            return null;
                        }
                        public void checkClientTrusted(X509Certificate[] certs,
                                                       String authType) {
                        }
                        public void checkServerTrusted(X509Certificate[] certs,
                                                       String authType) {
                        }
                    } };
            // Install the all-trusting trust manager
            SSLContext sc = SSLContext.getInstance("TLS");
            sc.init(null, trustAllCerts, new SecureRandom());
            HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());
            URL url = new URL(addr);
            conn = (HttpsURLConnection) url.openConnection();
            conn.setHostnameVerifier(new HostnameVerifier() {
                @Override
                public boolean verify(String arg0, SSLSession arg1) {
                    return true;
                }
            });
            conn.connect();
            System.out.println(conn.getResponseCode() + " " + conn.getResponseMessage());
            BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line;
            while ((line = reader.readLine()) != null) {
                stb.append(line);
            }
            reader.close();
        } catch (Exception e) {
            e.printStackTrace();
        }finally{
            if(conn != null){
                conn.disconnect();
            }
        }
        return stb.toString();
    }

    public static void main(String[] args) throws IOException {
        String s = doGetByHttps(Constants.GOTYE_URL.concat("&method=createRoom"));//.concat("&roomId=eyJjaGFubmVsSWQiOiIxOTkiLCJyb29tSWQiOjk0ODg2OCwic2VydmVySWQiOjcxODYsInR5cGUiOjF9"));
//        System.out.println("创建聊天室id为-->> " + s);  //{"status":200,"statusStr":"成功","roomId":"eyJjaGFubmVsSWQiOiIxOTkiLCJyb29tSWQiOjk0ODg2OCwic2VydmVySWQiOjcxODYsInR5cGUiOjF9"}
//                                                                                                   eyJjaGFubmVsSWQiOiIyMDgiLCJyb29tSWQiOjk1MDQ0OSwic2VydmVySWQiOjcxODYsInR5cGUiOjF9

        System.out.println(s);


    }


}
