package com.boot.demo.util;


import com.google.common.collect.Maps;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import javax.servlet.http.HttpServletRequest;
import java.util.Map;

public class ToolUtil {
	public static final Logger LOGGER = LoggerFactory.getLogger(ToolUtil.class);


	/**
	 * 获取客户端的ip信息
	 * 
	 * @param request
	 * @return
	 */
	public static String getClientIp(HttpServletRequest request) {
		String ip = request.getHeader("X-Real-IP");
		LOGGER.info("ipadd : " + ip);
		if (StringUtils.isBlank(ip) || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("X-Forwarded-For");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknow".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		LOGGER.info(" ip --> " + ip);
		return ip;
	}

	/**

	 * 通过文件名判断并获取OSS服务文件上传时文件的contentType

	 * @param fileName 文件名

	 * @return 文件的contentType

	 */
	public static  String getContentType(String fileName){
		int d = fileName.lastIndexOf(".");
		if( d== -1){
			return "text/html";
		}
		String fileExtension = fileName.substring(fileName.lastIndexOf("."));
		if(".bmp".equalsIgnoreCase(fileExtension)) return "image/bmp";
		if(".gif".equalsIgnoreCase(fileExtension)) return "image/gif";
		if(".jpeg".equalsIgnoreCase(fileExtension) || ".jpg".equalsIgnoreCase(fileExtension)) return "image/jpeg";
		if(".png".equalsIgnoreCase(fileExtension)) return "image/png";
		if(".html".equalsIgnoreCase(fileExtension)) return "text/html";
		if(".txt".equalsIgnoreCase(fileExtension)) return "text/plain";
		if(".vsd".equalsIgnoreCase(fileExtension)) return "application/vnd.visio";
		if(".ppt".equalsIgnoreCase(fileExtension) || ".pptx".equalsIgnoreCase(fileExtension)) return "application/vnd.ms-powerpoint";
		if(".doc".equalsIgnoreCase(fileExtension) || ".docx".equalsIgnoreCase(fileExtension)) return "application/msword";
		if(".xml".equalsIgnoreCase(fileExtension)) return "text/xml";
		return "text/html";
	}

	/**
	 * 判断请求是否是ajax请求
	 * @param request
	 * @return
	 */
	public static boolean isAjax(HttpServletRequest request){
		String accept = request.getHeader("accept");
        return accept != null && accept.contains("application/json") || (request.getHeader("X-Requested-With") != null && request.getHeader("X-Requested-With").contains("XMLHttpRequest"));
    }

	/**
	 * 获取操作系统,浏览器及浏览器版本信息
	 * @param request
	 * @return
	 */
	public static Map<String,String> getOsAndBrowserInfo(HttpServletRequest request){
		Map<String,String> map = Maps.newHashMap();
		String  browserDetails  =   request.getHeader("User-Agent");
		String  userAgent       =   browserDetails;
		String  user            =   userAgent.toLowerCase();

		String os = "";
		String browser = "";

		//=================OS Info=======================
		if (userAgent.toLowerCase().contains("windows"))
		{
			os = "Windows";
		} else if(userAgent.toLowerCase().contains("mac"))
		{
			os = "Mac";
		} else if(userAgent.toLowerCase().contains("x11"))
		{
			os = "Unix";
		} else if(userAgent.toLowerCase().contains("android"))
		{
			os = "Android";
		} else if(userAgent.toLowerCase().contains("iphone"))
		{
			os = "IPhone";
		}else{
			os = "UnKnown, More-Info: "+userAgent;
		}
		//===============Browser===========================
		if (user.contains("edge"))
		{
			browser=(userAgent.substring(userAgent.indexOf("Edge")).split(" ")[0]).replace("/", "-");
		} else if (user.contains("msie"))
		{
			String substring=userAgent.substring(userAgent.indexOf("MSIE")).split(";")[0];
			browser=substring.split(" ")[0].replace("MSIE", "IE")+"-"+substring.split(" ")[1];
		} else if (user.contains("safari") && user.contains("version"))
		{
			browser=(userAgent.substring(userAgent.indexOf("Safari")).split(" ")[0]).split("/")[0]
					+ "-" +(userAgent.substring(userAgent.indexOf("Version")).split(" ")[0]).split("/")[1];
		} else if ( user.contains("opr") || user.contains("opera"))
		{
			if(user.contains("opera")){
				browser=(userAgent.substring(userAgent.indexOf("Opera")).split(" ")[0]).split("/")[0]
						+"-"+(userAgent.substring(userAgent.indexOf("Version")).split(" ")[0]).split("/")[1];
			}else if(user.contains("opr")){
				browser=((userAgent.substring(userAgent.indexOf("OPR")).split(" ")[0]).replace("/", "-"))
						.replace("OPR", "Opera");
			}

		} else if (user.contains("chrome"))
		{
			browser=(userAgent.substring(userAgent.indexOf("Chrome")).split(" ")[0]).replace("/", "-");
		} else if ((user.contains("mozilla/7.0")) || (user.contains("netscape6"))  ||
				(user.contains("mozilla/4.7")) || (user.contains("mozilla/4.78")) ||
				(user.contains("mozilla/4.08")) || (user.contains("mozilla/3")) )
		{
			browser = "Netscape-?";

		} else if (user.contains("firefox"))
		{
			browser=(userAgent.substring(userAgent.indexOf("Firefox")).split(" ")[0]).replace("/", "-");
		} else if(user.contains("rv"))
		{
			String IEVersion = (userAgent.substring(userAgent.indexOf("rv")).split(" ")[0]).replace("rv:", "-");
			browser="IE" + IEVersion.substring(0,IEVersion.length() - 1);
		} else
		{
			browser = "UnKnown, More-Info: "+userAgent;
		}
		map.put("os",os);
		map.put("browser",browser);
		return map;
	}

}
