package com.audiovisualcenter.util;

import java.io.File;
import java.util.Date;

import javax.servlet.ServletContext;

import org.apache.commons.io.FileUtils;

//文件工具类
public class FileUtil {
	//上传文件
	public static String uploadFile(File file, String fileFileName, String fileContentType, String modifyStr,int i, ServletContext sc){
		String savePath="resource/pic";
		
		String contentPath = sc.getRealPath("");
		String path = contentPath + File.separator +savePath;
		String upfileName = getFileName(modifyStr, fileFileName, i);
		
//		System.out.println(upfileName);
		File f = new File(path, upfileName);
		try {
			if(f.exists()){
				f.delete();
			}
			FileUtils.copyFile(file, f);
			return savePath+File.separator+upfileName;
		} catch (Exception e) {
			return null;
		}
	}
	//获得文件名
	public static String getFileName(String modifyStr, String fileName, int i){
		Date d = new Date();
		String format = "yyyyMMddHHmmss";
		String fName = null;
		if(i==-1){
			fName = modifyStr + FormatUtil.formatDate(d, format)  + FileUtil.getType(fileName);
		}else{
			fName = modifyStr + FormatUtil.formatDate(d, format)  + i +  FileUtil.getType(fileName);
		}
		return fName;
	}
	//获得文件类型
		public static String getType(String fileName){
			return fileName.substring(fileName.lastIndexOf("."));
		}
}
