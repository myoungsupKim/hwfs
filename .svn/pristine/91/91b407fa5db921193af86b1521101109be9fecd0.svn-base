// [속도개선 Project 시작] 2017. 7. 11. 최범주 입고일자별 조회기능 추가
package com.hwfs.sc.cmn.util;

import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.TreeMap;

/**
 * 프로젝트에서 공통으로 사용하는 ConcurrentNumberFormatAccess
 * 클래스명   : 동시성 숫자패턴 처리
 * 클래스설명 : 숫자 패턴 적용 객체 생성 시 자원 사용을 최소화 하기 위해 객체를 Thread 캐시 처리하는 유틸이다.
 * @ClassName ConcurrentNumberFormatAccess.java
 * @Description ConcurrentNumberFormatAccess Class 
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
public class ConcurrentNumberFormatAccess {
    private static ThreadLocal<TreeMap<String, NumberFormat>> threadLocal = new ThreadLocal<TreeMap<String, NumberFormat>>() {
        @Override
        protected TreeMap<String, NumberFormat> initialValue() {
            return new TreeMap<String, NumberFormat>();
        }
    };

    /**
     * 숫자 패턴 적용된 NumberFormat 객체 얻기<br>
     * 패턴 별 Thread 캐시된 NumberFormat을 얻는다. 없으면 캐시한다.<br>
     * 
     * @param pattern 숫자 패턴
     * @return 숫자 패턴 적용된 NumberFormat 객체
     */
    public static NumberFormat getNumberFormat(String pattern) {
        TreeMap<String, NumberFormat> treeMap = threadLocal.get();
        NumberFormat numberFormat = treeMap.get(pattern);
        if (null == numberFormat) {
            numberFormat = new DecimalFormat(pattern);
            treeMap.put(pattern, numberFormat);
        }
        return numberFormat;
    }
}
// [속도개선 Project   끝] 2017. 7. 11. 최범주