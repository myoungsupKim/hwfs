// [속도개선 Project 시작] 2017. 7. 11. 최범주 입고일자별 조회기능 추가
package com.hwfs.sc.cmn.util;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Locale;
import java.util.TreeMap;

/**
 * 프로젝트에서 공통으로 사용하는 ConcurrentDateFormatAccess
 * 클래스명   : 동시성 일자패턴 처리
 * 클래스설명 : 일자 패턴 적용 객체 생성 시 자원 사용을 최소화 하기 위해 객체를 Thread 캐시 처리하는 유틸이다.
 * @ClassName ConcurrentDateFormatAccess.java
 * @Description ConcurrentDateFormatAccess Class 
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
public class ConcurrentDateFormatAccess {
    private static ThreadLocal<TreeMap<String, DateFormat>> threadLocal = new ThreadLocal<TreeMap<String, DateFormat>>() {
        @Override
        protected TreeMap<String, DateFormat> initialValue() {
            return new TreeMap<String, DateFormat>();
        }
    };

    /**
     * 일자 패턴 적용된 DateFormat 객체 얻기<br>
     * 패턴 별 Thread 캐시된 DateFormat을 얻는다. 없으면 캐시한다.<br>
     * 
     * @param pattern 일자 패턴
     * @return 일자 패턴 적용된 DateFormat 객체
     */
    public static DateFormat getDateFormat(String pattern) {
        TreeMap<String, DateFormat> treeMap = threadLocal.get();
        DateFormat dateFormat = treeMap.get(pattern);
        if (null == dateFormat) {
            dateFormat = new SimpleDateFormat(pattern, Locale.KOREA);
            treeMap.put(pattern, dateFormat);
        }
        return dateFormat;
    }
}
// [속도개선 Project   끝] 2017. 7. 11. 최범주