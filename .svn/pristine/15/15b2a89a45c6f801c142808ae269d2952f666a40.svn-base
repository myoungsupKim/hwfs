// [속도개선 Project 시작] 2017. 7. 11. 최범주 입고일자별 조회기능 추가
package com.hwfs.sc.cmn.util;

import hone.core.util.record.RecordSet;

import java.lang.reflect.Array;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 프로젝트에서 공통으로 사용하는 ValidationUtil
 * 클래스명   : 유효성 검증 유틸
 * 클래스설명 : 유효성 검증을 하는 공통 유틸이다.
 * @ClassName ValidationUtil.java
 * @Description ValidationUtil Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2017.07.13.  최범주        최초생성
 * </pre>
 * @author FC종합전산구축 : 최범주
 * @since 2017.07.13.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class ValidationUtil {

    /** 클래스 이름 */
    protected static String source_class = ValidationUtil.class.getName();

    /** 로거 */
    private final Logger logger = LoggerFactory.getLogger (this.getClass());

    /**
     * 공백 여부 체크<br>
     * 대상(source)이 공백인지 여부를 체크<br>
     * null 처리 후 비교
     * 
     * @param source 대상
     * @return 공백 여부(공백:true, 공백 아니면 false)
     */
    public static boolean isEmpty(String source) {
        boolean result = false;

        if (source == null) {
            return true;
        }

        if (source.length() == 0) {
            result = true;
        }

        return result;
    }
    
// [속도개선 Project 시작] 2017. 8. 4. 최범주 여신금액 집계 프로시저 추가
    public static boolean isEmpty(RecordSet source) {
    	boolean result = false;

        if (source == null) {
            return true;
        }

        if (source.getRowCount() == 0) {
            result = true;
        }

    	return result;
    }
// [속도개선 Project   끝] 2017. 8. 4. 최범주

    /**
     * Array 빈값 여부 체크<br>
     * 
     * <br>
     * ex) String[] array = {"11", "22"};<br>
     * boolean r = ValidationUtil.isEmpty(array); //r=false<br>
     * <br>
     * ex) String[] array = {};<br>
     * boolean r = ValidationUtil.isEmpty(array); //r=true<br>
     * <br>
     * ex) String[] array = null;<br>
     * boolean r = ValidationUtil.isEmpty(array); //r=true<br>
     * 
     * @param array 배열(String[], int[], ZSSS010BSVO[], ...)
     * @return Array 빈값 여부(true : 빈값, false : 크기 1 이상)
     */
    public static boolean isEmpty(Object[] array) {

        if (array == null)
            return true;

        if (Array.getLength(array) == 0)
            return true;

        return false;
    }

    /**
     * trim 후 공백 여부 체크<br>
     * trim 후 대상(source)이 공백인지 여부를 체크<br>
     * null, 공백 트림 처리 후 비교<br>
     * ex, boolean r = ValidationUtil.isEmptyTrim(" "); //r=true<br>
     * ex, boolean r = ValidationUtil.isEmptyTrim(null); //r=true<br>
     * ex, boolean r = ValidationUtil.isEmptyTrim(""); //r=true<br>
     * ex, boolean r = ValidationUtil.isEmptyTrim("a"); //r=false<br>
     * 
     * @param source 대상
     * @return 공백 여부(공백:true, 공백 아니면 false)
     */
    public static boolean isEmptyTrim(String source) {
        boolean result = false;

        if (source == null) {
            return true;
        }

        if (source.length() == 0) {
            result = true;
        } else {
            String str = StringUtil.nullTrim(source);

            if (str.length() == 0) {
                result = true;
            }
        }

        return result;
    }
    
// [속도개선 Project 시작] 2017. 7. 21. 최범주 사용자가 FS사업부일 경우 담당마케터 콤보 셋팅 기능 추가
    /**
     * 동일 여부 체크<br>
     * 대상(source)와 비교대상(compareValue)가 같은지 여부 체크<br>
     * null --> "" 처리 후 비교<br>
     * ex, boolean r = ValidationUtil.isEquals("111", "111");//r=true<br>
     * ex, boolean r = ValidationUtil.isEquals("111", "  111  ");//r=false<br>
     * ex, boolean r = ValidationUtil.isEquals(null, "");//r=true<br>
     * ex, boolean r = ValidationUtil.isEquals(null, null);//r=true<br>
     * 
     * @param source 대상
     * @param compareValue 비교 대상
     * @return 동일 여부(같으면 true, 다르면 false)
     */
    public static boolean isEquals(String source, String compareValue) {
        
        boolean result = true;

        if (source == null && compareValue == null)
            return true;

        if (source == null || compareValue == null)
            return false;

        // both not null
        int src_len = source.length();

        if (src_len != compareValue.length())
            return false;

        for (int i = 0; i < src_len; i++) { // same length
            if (source.charAt(i) != compareValue.charAt(i))
                return false;
        }

        return result;
    }
    
    /**
     * trim 후 동일 여부 체크<br>
     * 대상(source)와 비교대상(compareValue)가 같은지 여부 체크<br>
     * null, 공백 트림 처리 후 비교<br>
     * ex, boolean r = ValidationUtil.isEqualsTrim("111", "111");//r=true<br>
     * ex, boolean r = ValidationUtil.isEqualsTrim("111", "  111  ");//r=true<br>
     * ex, boolean r = ValidationUtil.isEqualsTrim(null, "");//r=true<br>
     * ex, boolean r = ValidationUtil.isEqualsTrim(null, null);//r=true<br>
     * 
     * @param source 대상
     * @param compareValue 비교 대상
     * @return 동일 여부(같으면 true, 다르면 false)
     */
    public static boolean isEqualsTrim(String source, String compareValue) {
        boolean result = false;

        String strSource = StringUtil.nullTrim(source);
        String strCompare = StringUtil.nullTrim(compareValue);

        if (strSource.equals(strCompare)) {
            result = true;
        }

        return result;
    }
    
    /**
     * OR 조건으로 값 존재 확인<br>
     * OR 조건의 대상 문자열(source)에서 값(val)이 존재하는지 확인한다.<br>
     * OR 조건 : 구분자("|")로 구분된 조건<br>
     * <br>
     * ex, boolean r = ValidationUtil.isEqualsOr("G", "M|G|R"); //r=true<br>
     * ex, boolean r = ValidationUtil.isEqualsOr("CF", "CF|CG"); //r=true<br>
     * ex, boolean r = ValidationUtil.isEqualsOr("null", "CF|CG"); //r=false<br>
     * ex, boolean r = ValidationUtil.isEqualsOr("CF", "null"); //r=false<br>
     * ex, boolean r = ValidationUtil.isEqualsOr("CF", "CF"); //r=true<br>
     * ex, boolean r = ValidationUtil.isEqualsOr("CF", "CA|CB|CC"); //r=false<br>
     * 
     * @param val 조회 값(ex, "G")
     * @param source 대상 문자열(ex, "M|G|R")
     * @return 존재 여부(같으면 true, 다르면 false)(ex, true)
     */
    public static boolean isEqualsOr(String val, String source) {
        String delim = "|";
        return isEqualsOr(val, source, delim);
    }
    
    /**
     * OR 조건으로 값 존재 확인<br>
     * OR 조건의 대상 문자열(source)에서 값(val)이 존재하는지 확인한다.<br>
     * OR 조건 : 구분자(delim)로 구분된 조건<br>
     * <br>
     * ex, boolean r = ValidationUtil.isEqualsOr("G", "M|G|R", "|"); //r=true<br>
     * ex, boolean r = ValidationUtil.isEqualsOr("CF", "CF|CG", "|"); //r=true<br>
     * ex, boolean r = ValidationUtil.isEqualsOr("null", "CF|CG", "|"); //r=false<br>
     * ex, boolean r = ValidationUtil.isEqualsOr("CF", "null", "|"); //r=false<br>
     * ex, boolean r = ValidationUtil.isEqualsOr("CF", "CF|CG", ""); //r=false<br>
     * ex, boolean r = ValidationUtil.isEqualsOr("CF", "CF", "|"); //r=true<br>
     * ex, boolean r = ValidationUtil.isEqualsOr("CF", "CA|CB|CC", "|"); //r=false<br>
     * ex, boolean r = ValidationUtil.isEqualsOr("G", "M,G,R", ","); //r=true<br>
     * 
     * @param val 조회 값(ex, "G")
     * @param source 대상 문자열(ex, "M|G|R")
     * @param delim 구분자(ex, "|")
     * @return 존재 여부(같으면 true, 다르면 false)(ex, true)
     */
    public static boolean isEqualsOr(String val, String source, String delim) {
        boolean result = false;

        if (ValidationUtil.isEmpty(val)) { // 조회 값
        	System.out.println("조회 값[val=" + val + "]이 존재하지 않습니다.");
            return result;
        }

        if (ValidationUtil.isEmpty(source)) { // 대상 문자열
        	System.out.println("대상 문자열[source=" + source +"]이 존재하지 않습니다.");
            return false;
        }

        if (ValidationUtil.isEmpty(delim)) { // 구분자
        	System.out.println("구분자[delim=" + delim + "]가 존재하지 않습니다.");
            return false;
        }

        String[] valArr = StringUtil.split(source, delim);

        for (String str : valArr) {
            if (val.equals(str)) {
                result = true;
                break;
            }
        }

        return result;
    }
// [속도개선 Project   끝] 2017. 7. 21. 최범주
    
// [속도개선 Project 시작] 2017. 7. 27. 최범주 조회정보 메일발송기능 추가
    /**
     * 전자메일 유효성 체크<br>
     * boolean r = ValidationUtil.isEmail(email);//r=true<br>
     * 
     * @param email 전자메일
     * @return 전자메일 유효성 여부(true:유효, false:유효하지 않는 경우)
     */
    public static boolean isEmail(String email) {
        String expression = "^[_A-Za-z0-9-]+(\\.[_A-Za-z0-9-]+)*@[_A-Za-z0-9-]+(\\.[_A-Za-z0-9-]+)*(\\.[A-Za-z]{2,})$";

        CharSequence inputStr = email;
        Pattern pattern = Pattern.compile(expression, Pattern.CASE_INSENSITIVE);
        Matcher matcher = pattern.matcher(inputStr);
        return matcher.matches();
    }
// [속도개선 Project   끝] 2017. 7. 27. 최범주
}
// [속도개선 Project   끝] 2017. 7. 11. 최범주