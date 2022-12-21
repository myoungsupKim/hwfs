package com.hwfs.sc.cmn.util;

import java.math.BigDecimal;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

 /**
 * 프로젝트에서 공통으로 사용하는 String Utility
 * - Framework에서 제공하는 StringUtil을 확장하여 만든다.
 * @ClassName StringUtil.java
 * @Description StringUtil Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2014. 12. 8.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2014. 12. 8.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class StringUtil extends com.hwfs.cmn.util.StringUtil {

    /**
     * String이 Null인 경우 디폴트 값으로 반환한다.
     * 
     * @param str
     * @param defaultValue
     * @return
     */
    public static String null2string(String str, String defaultValue) {

        if (isNull(str)) {
            return defaultValue;
        }

        return str;
    }
    
    /**
	 * 
	 * @param arg0
	 * @return
	 */
	public static boolean isObjNull(Object arg0) {
		return (arg0 == null);
	}
    
    /**
     * JsonArray를 List<Map>으로 변환한다.
     *
     * @param jsonArrStr
     * @return List<Map>
     * @throws JSONException
     */
    public static List<Map<String,Object>> jsonArr2Map (String jsonArrStr) throws JSONException {
		//JsonArray를 List<Map>으로 변환
		List<Map<String, Object>> listParam = new ArrayList<Map<String, Object>>();
		JSONArray jsonParam = new JSONArray (jsonArrStr);
		for (int i=0; i<jsonParam.length(); i++) {
			Map<String, Object> map = new HashMap<String, Object>();
			JSONObject json = jsonParam.getJSONObject(i);
			@SuppressWarnings("rawtypes")
			Iterator iter = json.keys();
			while (iter.hasNext()) {
				String key = iter.next().toString();
				map.put(key, json.getString(key));
			}
			listParam.add(map);
		}
		
		return listParam;
    }
    
    /**
	 * 
	 * @param arg0
	 * @return
	 */
	public static String nvl(String arg0) {
		if (isNull(arg0)) {
			return "";
		} else {
			return arg0;
		}
	}
	
	/**
	 * 
	 * @param arg0
	 * @return
	 */
	public static String nvl(Object arg0) {
		if (isObjNull(arg0)) {
			return "";
		} else {
			return String.valueOf(arg0);
		}
	}
	
	/**
	 * 
	 * @param arg0
	 * @param arg1
	 * @return
	 */
	public static String nvl(String arg0, String arg1) {
		if (isNull(arg0)) {
			return arg1;
		} else {
			return arg0;
		}
	}

	/**
	 * 
	 * @param arg0
	 * @param arg1
	 * @return
	 */
	public static int nvl(String arg0, int arg1) {
		if (isNull(arg0)) {
			return arg1;
		} else {
			return Integer.parseInt(arg0);
		}
	}
	
	/**
	 * 한글 포함여부를 판단하여 리턴
	 * 
	 * @param char character
	 * @return boolean 한글 여부
	 */	
	public static boolean isHangul(char ch) {
		java.lang.Character.UnicodeBlock unicodeBlock = java.lang.Character.UnicodeBlock.of(ch);

		if(java.lang.Character.UnicodeBlock.HANGUL_SYLLABLES.equals(unicodeBlock) || java.lang.Character.UnicodeBlock.HANGUL_COMPATIBILITY_JAMO.equals(unicodeBlock) 
				|| java.lang.Character.UnicodeBlock.HANGUL_JAMO.equals(unicodeBlock)) {
			return true;
		}
		
		return false;
	}
	
	/**
	 * 
	 * @param arg0
	 * @return
	 */
	public static String trimStr(String arg0) {
		if (isNull(arg0)) {
			return "";
		} else {
			return arg0.trim();
		}
	}
	
// [속도개선 Project 시작] 2017. 7. 11. 최범주 입고일자별 조회기능 추가
    /**
     * 특정 문자열 없애기<br>
     * source(스트링)에서 deleteStr(삭제할 문자열) 없애기<br>
     * String r = Util.deleteStr("01234567890123456", "012"); //r="34567893456"
     * 
     * @param source 대상 문자열
     * @param deleteStr 삭제할 문자열
     * @return 삭제할 문자열이 제거된 문자열
     */
    public static String deleteStr(String source, String deleteStr) {
        return replace(source, deleteStr, "");
    }
    
    /**
     * NULL 값/양쪽 공백 제거<br>
     * 대상(source)의 값의 null이나 양쪽 공백 문자를 제거해 준다. <br>
     * null ==> "", " e " ==> "e"
     * 
     * @param source 대상
     * @return String 대상 문자(null, 공백) 제거 후 값
     */
    public static String nullTrim(String source) {
        String result = null;

        if (source == null)
            result = "";
        else
            result = source.trim();

        return result;
    }
    
    /**
     * 숫자 포맷팅<br>
     * 문자 값(value)에 포맷(format)을 적용한 문자열을 얻는다.<br>
     * 소수점 표현 시 반올림 한다.<br>
     * 소수점 표현 시 절사 형식은 Util.cutDecimal() 함수를 사용하세요.<br>
     * ex) <br>
     * String a = Util.getFormatNumber("1", "000"); // return "001"<br>
     * String b = Util.getFormatNumber("1", "###"); // return "1"<br>
     * String c = Util.getFormatNumber("1", "#00"); // return "01"<br>
     * String r = Util.getFormatNumber("1000000"), "#,##0"); // return "1,000,000"<br>
     * String r = Util.getFormatNumber("1000.1234", "#,##0.0"); // return "1,000.1"<br>
     * String r = Util.getFormatNumber("1000.1534", "#,##0.0"); // return "1,000.2"<br>
     * String r = Util.getFormatNumber("1000.1234", "#,##0.00"); // return "1,000.12"<br>
     * String r = Util.getFormatNumber("1000.1554", "#,##0.00"); // return "1,000.16"<br>
     * 
     * @param value 문자 값
     * @param format 포맷(java.text.DecimalFormat API를 참조)
     * @return 문자 값(value)에 포맷(format)을 적용한 문자열
     */
    public static String getFormatNumber(String value, String format) {

        String rst = "";

        NumberFormat df = ConcurrentNumberFormatAccess.getNumberFormat(format);
        rst = df.format(Double.parseDouble(value));

        return rst;
    }

    /**
     * 숫자 포맷팅<br>
     * 숫자 값(value)에 포맷(format)을 적용한 문자열을 얻는다.<br>
     * ex) <br>
     * String a = Util.getFormatNumber(1, "000"); // return "001"<br>
     * String b = Util.getFormatNumber(1, "###"); // return "1"<br>
     * String c = Util.getFormatNumber(1, "#00"); // return "01"<br>
     * String r = Util.getFormatNumber(1000000"), "#,##0"); // return "1,000,000"<br>
     * 
     * @param value 숫자 값
     * @param format 포맷(java.text.DecimalFormat API를 참조)
     * @return 숫자 값(value)에 포맷(format)을 적용한 문자열
     */
    public static String getFormatNumber(int value, String format) {

        String rst = "";

        NumberFormat df = ConcurrentNumberFormatAccess.getNumberFormat(format);
        rst = df.format(value);

        return rst;
    }

    /**
     * 숫자 포맷팅<br>
     * 숫자 값(value)에 포맷(format)을 적용한 문자열을 얻는다.<br>
     * ex) <br>
     * String a = Util.getFormatNumber(1, "000"); // return "001"<br>
     * String b = Util.getFormatNumber(1, "###"); // return "1"<br>
     * String c = Util.getFormatNumber(1, "#00"); // return "01"<br>
     * String r = Util.getFormatNumber(1000000"), "#,##0"); // return "1,000,000"<br>
     * 
     * @param value 숫자 값
     * @param format 포맷(java.text.DecimalFormat API를 참조)
     * @return 숫자 값(value)에 포맷(format)을 적용한 문자열
     */
    public static String getFormatNumber(long value, String format) {

        String rst = "";

        NumberFormat df = ConcurrentNumberFormatAccess.getNumberFormat(format);
        rst = df.format(value);

        return rst;
    }

    /**
     * 숫자 포맷팅<br>
     * 숫자 값(value)에 포맷(format)을 적용한 문자열을 얻는다.<br>
     * 소수점 표현 시 반올림 한다.<br>
     * 소수점 표현 시 절사 형식은 Util.cutDecimal() 함수를 사용하세요.<br>
     * ex) <br>
     * String a = Util.getFormatNumber(1, "000"); // return "001"<br>
     * String b = Util.getFormatNumber(1, "###"); // return "1"<br>
     * String c = Util.getFormatNumber(1, "#00"); // return "01"<br>
     * String r = Util.getFormatNumber(1000000"), "#,##0"); // return "1,000,000"<br>
     * String r = Util.getFormatNumber(1000.1234, "#,##0.0"); // return "1,000.1"<br>
     * String r = Util.getFormatNumber(1000.1534, "#,##0.0"); // return "1,000.2"<br>
     * String r = Util.getFormatNumber(1000.1234, "#,##0.00"); // return "1,000.12"<br>
     * String r = Util.getFormatNumber(1000.1554, "#,##0.00"); // return "1,000.16"<br>
     * 
     * @param value 숫자 값
     * @param format 포맷(java.text.DecimalFormat API를 참조)
     * @return 숫자 값(value)에 포맷(format)을 적용한 문자열
     */
    public static String getFormatNumber(float value, String format) {

        String rst = "";

        NumberFormat df = ConcurrentNumberFormatAccess.getNumberFormat(format);
        rst = df.format(value);

        return rst;
    }

    /**
     * 숫자 포맷팅<br>
     * 숫자 값(value)에 포맷(format)을 적용한 문자열을 얻는다.<br>
     * 소수점 표현 시 반올림 한다.<br>
     * 소수점 표현 시 절사 형식은 Util.cutDecimal() 함수를 사용하세요.<br>
     * ex) <br>
     * String a = Util.getFormatNumber(1, "000"); // return "001"<br>
     * String b = Util.getFormatNumber(1, "###"); // return "1"<br>
     * String c = Util.getFormatNumber(1, "#00"); // return "01"<br>
     * String r = Util.getFormatNumber(1000000"), "#,##0"); // return "1,000,000"<br>
     * String r = Util.getFormatNumber(1000.1234, "#,##0.0"); // return "1,000.1"<br>
     * String r = Util.getFormatNumber(1000.1534, "#,##0.0"); // return "1,000.2"<br>
     * String r = Util.getFormatNumber(1000.1234, "#,##0.00"); // return "1,000.12"<br>
     * String r = Util.getFormatNumber(1000.1554, "#,##0.00"); // return "1,000.16"<br>
     * 
     * @param value 숫자 값
     * @param format 포맷(java.text.DecimalFormat API를 참조)
     * @return 숫자 값(value)에 포맷(format)을 적용한 문자열
     */
    public static String getFormatNumber(double value, String format) {

        String rst = "";

        NumberFormat df = ConcurrentNumberFormatAccess.getNumberFormat(format);
        rst = df.format(value);

        return rst;
    }

    /**
     * 숫자 포맷팅<br>
     * 숫자 값(value)에 포맷(format)을 적용한 문자열을 얻는다.<br>
     * 소수점 표현 시 반올림을 사용한다.<br>
     * 소수점 표현 시 절사 형식은 Util.cutDecimal() 함수를 사용하세요.<br>
     * <br>
     * 
     * ex) <br>
     * String r = Util.getFormatNumber(new BigDecimal("1"), "000"); // return "001"<br>
     * String r = Util.getFormatNumber(new BigDecimal("1"), "###"); // return "1"<br>
     * String r = Util.getFormatNumber(new BigDecimal("1"), "#00"); // return "01"<br>
     * String r = Util.getFormatNumber(new BigDecimal("1000000"), "#,##0"); // return "1,000,000"<br>
     * String r = Util.getFormatNumber(new BigDecimal("1000.1234"), "#,##0.0"); // return "1,000.1"<br>
     * String r = Util.getFormatNumber(new BigDecimal("1000.1534"), "#,##0.0"); // return "1,000.2"<br>
     * String r = Util.getFormatNumber(new BigDecimal("1000.1234"), "#,##0.00"); // return "1,000.12"<br>
     * String r = Util.getFormatNumber(new BigDecimal("1000.1554"), "#,##0.00"); // return "1,000.16"<br>
     * 
     * @param value 숫자 값
     * @param format 포맷(java.text.DecimalFormat API를 참조)
     * @return 숫자 값(value)에 포맷(format)을 적용한 문자열
     */
    public static String getFormatNumber(BigDecimal value, String format) {

        String rst = "";

        NumberFormat df = ConcurrentNumberFormatAccess.getNumberFormat(format);
        rst = df.format(value);

        return rst;
    }
    
    /**
     * 구분자 넣어 문자열 연결하기<br>
     * strList는 동적 매개변수(str1, str2, str3, ....) 또는 배열<br>
     * 
     * ex, String r = Util.concatStrByDelim("/", "1", "2", "3", "4", "5"); //r="1/2/3/4/5"<br>
     * ex, String r = Util.concatStrByDelim("/", new String[]{"1", "2", "3", "4", "5"}); //r="1/2/3/4/5"<br>
     * 
     * @param delim 구분자
     * @param strList 문자열 리스트(동적 매개변수(str1, str2, str3, ....) or 배열)
     * @return 구분자 넣어 연결된 문자열(str1 + delim + str2 + delim + ...)
     */
    public static String concatStrListByDelim(String delim, String... strList) {
        if (strList == null)
            return "";

        StringBuffer sb = new StringBuffer();
        int len = strList.length;
        int lastIdx = len - 1;
        for (int i = 0; i < len; i++) {
            String str = (strList[i] == null ? strList[i] = "" : strList[i]);
            if (!str.trim().equals("")) {
                sb.append(str);

                if (lastIdx != i) {
                    sb.append(delim);
                }
            }
        }

        return sb.toString();
    }
    
    /**
     * 콤마 값을 IN 처리에 맞게 변경.
     *
     * @param list
     *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
     * @return 처리건수
     * @throws Exception
     */
    public static String getWhereInQuery(String value) {
    	String rst = "";

		if ( value.indexOf(',') != -1 ) {
			rst =  "'" + value.replaceAll(",", "','") + "'";
		} else {
			rst = "'" + value + "'";
		}
		
		return rst;
    }
// [속도개선 Project   끝] 2017. 7. 11. 최범주
}
