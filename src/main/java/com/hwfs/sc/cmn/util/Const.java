package com.hwfs.sc.cmn.util;

 /**
 * 시스템에서 사용하는 상수를 정의한다.
 * @ClassName Const.java
 * @Description Const Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 2. 13.   김재섭      최초생성
 * </pre>
 * @author FC종합전산구축 : 공통 김재섭
 * @since 2015. 2. 13.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class Const {


	 /**
	 * 개인정보 보안의 마스킹 권한의 모드를 관리한다.
	 * @ClassName Const.java
	 * @Description MaskAuthMode Class
	 * @Modification-Information
	 * <pre>
	 *    수정일       수정자              수정내용
	 *  ----------   ----------   -------------------------------
	 *  2015. 2. 13.   김재섭        최초생성
	 * </pre>
	 * @author FC종합전산구축 : 공통 김재섭
	 * @since 2015. 2. 13.
	 * @version 1.0
	 * @see
	 * <pre>
	 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
	 * </pre>
	 */
	public static class MaskAuthMode {
		/**
		 *  마스킹 처리
		 */
		public static final int MASK = 1;
		/**
		 * 비 마스킹 처리
		 */
		public static final int UN_MASK = 0;
	}


	 /**
	 * 권한 변경 이력에 대한 대상 TALBE
	 * @ClassName Const.java
	 * @Description AuthorityTable Class
	 * @Modification-Information
	 * <pre>
	 *    수정일       수정자              수정내용
	 *  ----------   ----------   -------------------------------
	 *  2015. 5. 18.   김재섭        최초생성
	 * </pre>
	 * @author FC종합전산구축 : COM 김재섭
	 * @since 2015. 5. 18.
	 * @version 1.0
	 * @see
	 * <pre>
	 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
	 * </pre>
	 */
	public static class AuthorityTable {

		/**
		 * 권한그룹 Table(0)
		 */
		public static final int SCC_ROLE = 0;

		/**
		 * 권한그룹별 메뉴 Table(1)
		 */
		public static final int SCC_ROLE_MENU = 1;

		/**
		 * 사용자별 권한그룹 Table(2)
		 */
		public static final int SCC_USER_ROLE = 2;

		/**
		 * 부서별 권한그룹 Table(3)
		 */
		public static final int SCC_DEPT_ROLE = 3;

		/**
		 * 사용자군별 권한그룹 Table(4)
		 */
		public static final int SCC_USER_GROUP_ROLE = 4;

		/**
		 * 사용자별 메뉴(예외) Table(5)
		 */
		public static final int SCC_USER_MENU = 5;
	}
	
// [속도개선 Project 시작] 2017. 6. 30. 최범주 매출보정이력 기능 추가
	/**
	 * 처리구분
	 */
	public final static String PROC_CLSS_I = "I";  // 등록
	public final static String PROC_CLSS_U = "U";  // 수정
	public final static String PROC_CLSS_D = "D";  // 삭제
// [속도개선 Project   끝] 2017. 6. 30. 최범주
	
// [속도개선 Project 시작] 2017. 7. 27. 최범주 조회정보 메일발송기능 추가
	/**
	 * 여부
	 */
    public final static String YN_Y = "Y";  // 여
    public final static String YN_N = "N";  // 부
    
    /**
     * 데이터타입
     */
    public final static String DATA_TYPE_TEXT   = "TEXT";    // 문자
    public final static String DATA_TYPE_NUMBER = "NUMBER";  // 숫자
    public final static String DATA_TYPE_DATE   = "DATE";    // 날짜
    
    /**
     * 엑셀 최대 건수
     */
    public final static int XLX_MAX_CNT  = 65536;    // Excel 2007 이전 버전
    public final static int XLSX_MAX_CNT = 1048576;  // Excel 2007 이상
// [속도개선 Project   끝] 2017. 7. 27. 최범주
    
// [속도개선 Project 시작] 2017. 8. 4. 최범주 여신금액 집계 프로시저 추가
    /**
     * 구매 I/F 처리 결과 코드
     */
    public final static String PURC_PROC_SUCC = "S000";  // 구매 I/F 처리 성공

    /**
     * 구매 클레임 처리 결과 코드
     */
    public final static String PURC_CLM_PROC_SUCC = "S";  // 정상처리
    
    /**
     * 클레임 처리 코드
     */
    public final static String CLM_PROC_C0301 = "C0301";  // 감량
    public final static String CLM_PROC_C0302 = "C0302";  // 기타입고
    public final static String CLM_PROC_C0303 = "C0303";  // 반품
    public final static String CLM_PROC_C0304 = "C0304";  // 업체교환
    public final static String CLM_PROC_C0305 = "C0305";  // 업체직송
    public final static String CLM_PROC_C0306 = "C0306";  // 익일입고
    public final static String CLM_PROC_C0307 = "C0307";  // 현지구매
    public final static String CLM_PROC_C0308 = "C0308";  // 기타
    public final static String CLM_PROC_C0309 = "C0309";  // 리조트감량
    
    /**
     * 과세 구분 코드
     */
    public final static String TXN_CLSS_100 = "100";  // 과세
    public final static String TXN_CLSS_210 = "210";  // 면세
    public final static String TXN_CLSS_220 = "220";  // 영세
// [속도개선 Project   끝] 2017. 8. 4. 최범주
}
