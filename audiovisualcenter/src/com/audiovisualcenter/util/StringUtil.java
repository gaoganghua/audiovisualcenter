package com.audiovisualcenter.util;

import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


//字符串帮助类
public class StringUtil {
	private static final String CHARARRAY[] = {"1", "2", "3", "4", "5",
			"6", "7", "8", "9", "0","a", "b", "c", "d", "e", "f", "g", "h", "i",
			"j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v",
			"w", "x", "y", "z" ,"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M",
			"N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"};
	public static final String CHARACTERRAY[]={
			"+", "-", "*", "/", "%"
	};
	private static final byte[] bus = {
		120, 15, 50, 14, 6, 0, 52, 35, 99, 8, 45, 34, 2, 87, 23, 45, 89, 10, 45, 1
	};
	private static String getRandChar(int randNumber) {
		return CHARARRAY[randNumber];
	}
	private static String getRandCharacter(int randNumber) {
		return CHARACTERRAY[randNumber];
	}
//	public static final byte BYTEARRAY[]  = {
//		2, 8, 58, 23, 14,
//	};
//	public static String getOperator(){
//		
//	}
	//获取验证码
	public static String[] getSafeCode(){
		String[] safecodes = new String[2];
		String srand = "";
		Random random = new Random();
			
		for(int i=0;i<4;i++){
			String rand = getRandChar(random.nextInt(62));
			srand = srand + rand;
		}
		safecodes[0]=srand;
		safecodes[1]=srand;
		return safecodes;
	}
	//获取验证码2(计算型)
	public static String[] getSafeCode2(){
		String[] safecodes = new String[2];
		String srand = "";
		String answer = null;
		Random random = new Random();
		boolean doflag = false;
		do{
			srand = "";
			int first;
			int last;
			srand = srand + getRandChar(random.nextInt(10));
			first = Integer.parseInt(srand);
			int operatorn = random.nextInt(5);
			String operator = getRandCharacter(operatorn);
			String lastChar = getRandChar(random.nextInt(9));
			last = Integer.parseInt(lastChar);
			if("/".equals(operator)){
				if(first%last!=0){
					doflag = true;
					continue;
				}
			}
			if("+".equals(operator)){
				answer = String.valueOf(first+last);
			}else if("-".equals(operator)){
				answer = String.valueOf(first-last);
			}else if("%".equals(operator)){
				answer = String.valueOf(first%last);
			}else if("/".equals(operator)){
				answer = String.valueOf(first/last);
			}else if("*".equals(operator)){
				answer = String.valueOf(first*last);
			}
			srand = srand + operator + lastChar + "=?";
			safecodes[0] = srand;
			safecodes[1] = answer;
		}while(doflag);
		return safecodes;
	}
	//加密
	public static String encrypt(String srcStr){
		if(srcStr==null || ("").equals(srcStr)){
			return null;
		}
		return toString(toEncryptByteArray(srcStr.getBytes()));
	}
	//解密
	public static String decrypt(String str){
		if(str==null || ("").equals(str)){
			return null;
		}
		return reconString(parseByteArray(str));
	}
	//检测邮箱地址是否合法 
	public static boolean isEmail(String email){
		if (null==email || "".equals(email)) return false;
		Pattern p = Pattern.compile("\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*");
		Matcher m = p.matcher(email);
		return m.matches();
	} 
    // 检测手机是否合法 
	public static boolean isPhone(String phone){
		if (null==phone || "".equals(phone)) return false;
		Pattern p = Pattern.compile("^0?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$");
		Matcher m = p.matcher(phone);
		return m.matches();
	}
	//检查是不是空字符串
	public static boolean isEmpty(String srcStr){
		if(srcStr==null)
			return true;
		if("".equals(srcStr.trim())){
			return true;
		}
		return false;
	}
	
	
	
	
	//byte转换
	public static byte[] toEncryptByteArray(byte[] bytes){
		int c=0;
		for(int i=0;i<bytes.length;i++,c++){
			bytes[i] = (byte)(bytes[i] ^ bus[c]);
			c = c%bus.length;
		}
		return bytes;
	}
	//转换string
	public static String toString(byte[] bytes){
		StringBuffer sb = new StringBuffer();
		String s = null;
		for(int i=0;i<bytes.length;i++){
			s = Integer.toHexString((int)bytes[i] & 0xff);
			if(s.length()==1){
				s = "0"+s;
			}
			sb.append(s);
		}
		return sb.toString();
	}
	//解析bytes
	public static byte[] parseByteArray(String str){
		byte[] bytes2 = new byte[str.length()/2];
		for(int i=0;i<str.length();i=i+2){
			String s = String.valueOf(str.charAt(i)) + String.valueOf(str.charAt(i+1));
			bytes2[i/2] = (byte)Integer.parseInt(s, 16);
		}
		return bytes2;
	}
	//重组字符串
	public static String reconString(byte[] bytes){
		bytes = toEncryptByteArray(bytes);
		return new String(bytes);
	}
	
}
