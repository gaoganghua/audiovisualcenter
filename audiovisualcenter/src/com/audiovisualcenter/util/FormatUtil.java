package com.audiovisualcenter.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class FormatUtil {
	public static String formatDate(Date d, String format){
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		return sdf.format(d);
	}
	public static Date parseDate(String dateStr, String format){
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		try {
			return sdf.parse(dateStr);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return null;
	}
//	public 	static String getFileName(){
//		
//	}
}
