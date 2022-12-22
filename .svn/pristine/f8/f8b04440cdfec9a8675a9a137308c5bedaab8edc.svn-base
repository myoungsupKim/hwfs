package com.hwfs.sc.cmn.util;

 /**
 * 프로젝트에서 공통으로 사용하는 Number Utility
 * - Framework에서 제공하는 NumnerUtil을 확장하여 만든다.
 * @ClassName NumberUtil.java
 * @Description NumberUtil Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2014.12.18.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2014.12.18.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class NumberUtil extends com.hwfs.cmn.util.NumberUtil {
	//TODO 프로젝트별로 추가하여 사용
// [속도개선 Project 시작] 2017. 8. 4. 최범주 여신금액 집계 프로시저 추가
    /**
     * 반올림 처리<br>
     * 반올림 값을 얻는다.<br>
     * scale 밑에 자리에서 반올림하여 scale 만큼 표시한 수를 얻는다.<br>
     * ex, round(100.235, 2) ==> 100.24<br>
     * ex, round(100.235, 1) ==> 100.2<br>
     * ex, round(100.235, 0) ==> 100.0<br>
     * ex, round(-100.235, 2) ==> -100.23<br>
     * ex, round(-100.235, 1) ==> -100.2<br>
     * ex, round(-100.235, 0) ==> -100.0<br>
     * 
     * @param val 반올림 할 값
     * @param scale 표시하고자 하는 자리수
     * @return 반올림 한 값
     */
    public static double round(double val, int scale) {
        int buf = 1;
        for (int i = 0; i < scale; i++) {
            buf = buf * 10;
        }

        double d = Math.round(val * buf);

        return d / buf;
    }
// [속도개선 Project   끝] 2017. 8. 4. 최범주
}
