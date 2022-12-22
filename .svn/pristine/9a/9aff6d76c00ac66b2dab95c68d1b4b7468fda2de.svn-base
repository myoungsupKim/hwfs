package com.hwfs.sc.cmn.util;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Locale;

import com.hwfs.cmn.util.NullUtil;
import com.sz.business.BusinessRuntimeException;

 /**
 * 프로젝트에서 공통으로 사용하는 Date Utility
 * - Framework에서 제공하는 DateUtil을 확장하여 만든다.
 * @ClassName DateUtil.java
 * @Description DateUtil Class 
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
public class DateUtil extends com.hwfs.cmn.util.DateUtil {
	//TODO 프로젝트별로 추가하여 사용
	
// [속도개선 Project 시작] 2017. 7. 11. 최범주 입고일자별 조회기능 추가
    /*
     * 년월(일) 일자 목록 얻기 - 양편단편모드 상수 값
     */
    /** 양편 **/
    public static final int MODE_BOTH_SIDES = 0;

    /** FROM 포함 단편 **/
    public static final int MODE_ONE_SIDE_INCLUDE_FROM = 1;

    /** TO 포함 단편 **/
    public static final int MODE_ONE_SIDE_INCLUDE_TO = 2;
	
    private static ThreadLocal<Calendar> calThreadLocal = new ThreadLocal<Calendar>();
// [속도개선 Project   끝] 2017. 7. 11. 최범주
	/**
	 * 날짜와 시각을 Yyyymmdd 형태로 반환한다.
	 *
	 * @param cal
	 * @return
	*/
	public static String getYyyymmdd(Date date) {
		if (date == null) return "";
		Locale currentLocale = new Locale("KOREAN", "KOREA");
	    String pattern = "yyyy-MM-dd";
	    SimpleDateFormat formatter = new SimpleDateFormat(pattern, currentLocale);
	    return formatter.format(date.getTime());
	}
	
	public static String addDay(int day, String format) {
		Calendar today = Calendar.getInstance();
		today.add(today.DATE, day);
		Locale currentLocale = new Locale("KOREAN", "KOREA");
		String pattern = format;
		SimpleDateFormat formatter = new SimpleDateFormat(pattern, currentLocale);
		return formatter.format(today.getTime());
	}

	/**
	 * 날짜와 시각을 Yyyymmddhhmmss 형태로 반환한다.
	 *
	 * @return
	*/
	public static String getYyyymmddhhmmss(Date date) {
		if (date == null) return "";
	    Locale currentLocale = new Locale("KOREAN", "KOREA");
	    String pattern = "yyyy-MM-dd HH:mm:ss";
	    SimpleDateFormat formatter = new SimpleDateFormat(pattern, currentLocale);
	    return formatter.format(date.getTime());
	}

	/**
	 * 현재 날짜와 시각을 YyyymmddhhmmssSSS 형태로 반환한다.
	 *
	 * @return
	*/
	public static String getTimestamp() {
		Calendar calendar = Calendar.getInstance();
	    Locale currentLocale = new Locale("KOREAN", "KOREA");
	    String pattern = "yyyyMMddHHmmssSSS";
	    SimpleDateFormat formatter = new SimpleDateFormat(pattern, currentLocale);
	    return formatter.format(calendar.getTime());
	}

	/**
	 * 현재 날짜와 시각을 YyyymmddhhmmssSSSSSS 형태로 반환한다.
	 *
	 * @return
	*/
	public static String getTimestamp6() {
		Calendar calendar = Calendar.getInstance();
	    Locale currentLocale = new Locale("KOREAN", "KOREA");
	    String pattern = "yyyyMMddHHmmssSSSSSS";
	    SimpleDateFormat formatter = new SimpleDateFormat(pattern, currentLocale);
	    return formatter.format(calendar.getTime());
	}

	/**
	 * 현재 날짜와 시각을 YyyymmddhhmmssSSSSSS + IP마지막 영역 형태로 반환한다.
	 *
	 * @return
	*/
	public static String getTimestamp6WithIp() {
		String strTimestamp = getTimestamp6();
	    
		/** 실행되고 있는 서버IP */
		String hostAddress;
		try {
			InetAddress inetAddress = InetAddress.getLocalHost();
			hostAddress = inetAddress.getHostAddress();
			int pos = hostAddress.lastIndexOf(".");
			if (pos != -1) hostAddress = hostAddress.substring(pos+1);
		} catch (UnknownHostException e) {
			hostAddress = "";
		}
		
		if (NullUtil.isNull(hostAddress))
			return strTimestamp;
		else	
			return strTimestamp + "-" +  hostAddress;
	}
	
    /**
     * <pre>
     * 시스템의 현재 날짜를 yyyyMM 형식으로 반환한다.
     * </pre>
     *
     * @return String yyyyMMdd 형식의 현재날짜
     */
    public static String getSysMonth() {
        return getSysDateStr("yyyyMM");
    }
    
    /**
     * <pre>
     * 두 날짜 사이의 일자를 반환한다.
     * </pre>
     *
     * @param fromDate yyyyMMdd 형식의 시작일자
     * @param toDate yyyyMMdd 형식의 종료일자
     * @return List<String> 두 날짜 사이의 일자
     *
     */   
    public static List<String> getBetweenDays(String fromDate, String toDate) throws ParseException {
    	// 반환할 일자 List 선언
    	List<String> betweenDays = new ArrayList<String>();
    	
    	// 날짜 포맷
    	DateFormat df = new SimpleDateFormat("yyyyMMdd", Locale.KOREAN);
    	
    	// String 형식에서 Date 형식으로 변환
		Date fd = df.parse(fromDate);
    	Date td = df.parse(toDate);
    	
    	// 날짜 계산을 위한 Calendar 초기화
    	Calendar cf = Calendar.getInstance();
    	Calendar ct = Calendar.getInstance();
    	
    	cf.setTime(fd);
    	ct.setTime(td);
    	
    	// 두 날짜 사이를 비교
    	while(cf.compareTo(ct) != 1) {
    		// 날짜 사이면 해당일자를 List에 추가
    		Date dt = cf.getTime();
    		betweenDays.add(df.format(dt));
    		// 1일씩 증가
    		cf.add(Calendar.DATE, 1);
    	}
		
		return betweenDays;

    }
    
    /**
     * <pre>
     * 시스템의 현재 날짜를 yyyy 형식으로 반환한다.
     * </pre>
     *
     * @return String yyyyMMdd 형식의 현재날짜
     */
    public static String getSysYear() {
        return getSysDateStr("yyyy");
    }  
    
    /**
    *
    * <pre>
    * 시스템의 현재날짜를 주어진 pattern 에 따라 반환한다.
    * </pre>
    *
    * @param pattern SimpleDateFormat 에 적용할 pattern
    * @return String pattern 형식의 현재날짜
    */
   public static String getSysDateStr(String pattern) {
       return convertToString(getSysTimeStamp(), pattern);
   }
   
   /**
   *
   * <pre>
   * 시스템의 현재 날짜를 yyyyMMdd 형식으로 반환한다.
   * </pre>
   *
   * @return String yyyyMMdd 형식의 현재날짜
   */
  public static String getSysDate() {
      return getSysDateStr("yyyyMMdd");
  }
   
   /**
   *
   * <pre>
   *  시스템의 현재날짜를 구해 현재 Timestamp로 반환한다.
   * </pre>
   *
   * @return Timestamp 현재 시스템의 Timestamp
   *
   */
  public static Timestamp getSysTimeStamp() {
      Calendar cal = new GregorianCalendar();
      return new Timestamp(cal.getTime().getTime());
  }
  
  /**
  *
  * <pre>
  * yyyyMMdd 형식의 Timestamp 날짜를 pattern 에 따른 형식으로 반환한다.
  * </pre>
  *
  * @param ts Timestamp 형식의 날짜
  * @param pattern SimpleDateFormat 에 적용할 pattern
  * @return Timestamp 날짜
  * @exception
  */
 public static String convertToString(Timestamp ts, String pattern) {
     return convertToString(ts, pattern, Locale.KOREA);
 }
 
 /**
 *
 * <pre>
 * yyyyMMdd 형식의 Timestamp 날짜를 pattern 과 locale 에 따른 형식으로 반환한다.
 * </pre>
 *
 * @param tsDate Timestamp 형식의 날짜
 * @param ts SimpleDateFormat 에 적용할 pattern
 * @param locale 국가별 LOCALE
 * @return String pattern 형식의 Timestamp 날짜
 *
 */
public static String convertToString(Timestamp ts, String pattern, Locale locale) {
    if (ts == null) {
        return "";
    }
    SimpleDateFormat formatter = new SimpleDateFormat(pattern, locale);
    return formatter.format(ts);
}

// [속도개선 Project 시작] 2017. 7. 11. 최범주 입고일자별 조회기능 추가
	/**
	 * 일 차이 얻기<br>
	 * yyyyMMdd, yyyy-MM-dd 패턴의 두 일자를 입력 받아 일 차이를 얻는다.<br>
	 * ex, int r = DateUtil.getGapForDay("20101010", "20101030");//r=20<br>
	 * ex, int r = DateUtil.getGapForDay("20101220", "20110120");//r=31<br>
	 * ex, int r = DateUtil.getGapForDay("2010-10-10", "2010-10-30");//r=20<br>
	 * ex, int r = DateUtil.getGapForDay("2010-12-20", "2011-01-20");//r=31<br>
	 * 
	 * @param fromDate 시작일(yyyyMMdd or yyyy-MM-dd)
	 * @param toDate 종료일(yyyyMMdd or yyyy-MM-dd)
	 * @return 두 일자간 일의 차이
	 */
	public static int getGapForDay(String fromDate, String toDate) {
        if ( fromDate == null ) {
        	throw new BusinessRuntimeException("시작일자 는(은) 필수 입력항목입니다.");
        }

        if ( toDate == null ) {
        	throw new BusinessRuntimeException("종료일자 는(은) 필수 입력항목입니다.");
        }

        long str_days = getDays(StringUtil.deleteStr(fromDate, "-"));
        long end_days = getDays(StringUtil.deleteStr(toDate, "-"));
        return (int)(end_days - str_days) ;
	}
	
    /**
     * 율리우스 적일(Julian Date) 얻기
     * 4713년 B.C.부터 계수한 날 수이다.<br>
     * <pre>
     * 율리우스 적일(Julian Date)은 다음과 같이 정의된다.
     * 
     * 장소 : 영국 그리니치(Greenwich, 경도 0도) 기준
     * 시점 : B.C. 4713년 1월 1월 세계시 12시부터 세어진 날의 수
     * 
     * 율리우스 적일(이하, JD)는 '어느 시점부터 몇 일째 되는 날'과 같이 날짜를 세는 방법이라고 생각하면 된다. 
     * 적일에서 '적(積)'자는 쌓을 적자이다. 즉 날짜를 쌓아간다는 의미이다. 
     * 한가지 더 고려해야할 것은 단순히 날짜만 세는 것이 아니라 소수점까지 포함한 시간까지 확장한다. 
     * 그러므로 JD는 날짜와 시간을 하나의 실수값으로 정의가 가능해진다.
     * 
     * example)
     * input      return
     * -------------------
     * 19510101   2433648
     * 19900524   2448036
     * 19900623   2448066
     * 20010101   2451911
     * 20101010   2455480
     * 20101030   2455500
     * 20101220   2455551
     * 20120421   2456039
     * 20200430   2458970
     * </pre>
     * 
     * @param s 일자(yyyyMMdd)
     * @return 4713년 B.C.부터 계수한 날 수
     */
    private static int getDays(String s) {
        int i = Integer.parseInt(s);
        int year = i / 10000;
        int month = i % 10000 / 100;
        int day = i % 100;
        if (3 > month) {
            year -= 1;
            month += 12;
        }
        int a = (int) (year / 100);
        int b = 2 - a + ((int) (a / 4));
        int pastDays = (int) (365.25 * (year + 4716)) + (int) (30.6001 * (month + 1)) + day + b - 1524;
        return (pastDays);
    }
    
    /**
     * 월 차이 얻기<br>
     * (yyyyMMdd, yyyy-MM-dd 형태) 시작일 과 종료일을 받아, 두 일자간의 월 차이를 구한다.<br>
     * int r = DateUtil.getGapForMonth("20110102", "20110301"); //r=1<br>
     * int r = DateUtil.getGapForMonth("20110102", "20110302"); //r=2<br>
     * int r = DateUtil.getGapForMonth("20110102", "20110303"); //r=2<br>
     * int r = DateUtil.getGapForMonth("20101002", "20110303"); //r=5<br>
     * int r = DateUtil.getGapForMonth("2011-01-02", "2011-03-01"); //r=1<br>
     * int r = DateUtil.getGapForMonth("2011-01-02", "2011-03-02"); //r=2<br>
     * int r = DateUtil.getGapForMonth("2011-01-02", "2011-03-03"); //r=2<br>
     * int r = DateUtil.getGapForMonth("2010-10-02", "2011-03-03"); //r=5<br>
     * 
     * @param fromDate 시작일(yyyyMMdd or yyyy-MM-dd)
     * @param toDate 종료일(yyyyMMdd or yyyy-MM-dd)
     * @param blnJustMonth 일 무시 여부 (true : 일자계산하여 월차이 구함, false : 일자무시). defualt : false
     * @return 두 일자간 월의 차이
     */
    public static int getGapForMonth(String fromDate, String toDate) {
    	return getGapForMonth(fromDate, toDate, false);
    }
    
    public static int getGapForMonth(String fromDate, String toDate, boolean blnJustMonth) {

        if (fromDate == null) {
        	throw new BusinessRuntimeException("시작일자 는(은) 필수 입력항목입니다.");
        }

        if (toDate == null) {
        	throw new BusinessRuntimeException("종료일자 는(은) 필수 입력항목입니다.");
        }

        fromDate = StringUtil.deleteStr(fromDate, "-");
        toDate = StringUtil.deleteStr(toDate, "-");

        int yearGap = Integer.parseInt(toDate.substring(0, 4)) - Integer.parseInt(fromDate.substring(0, 4));
        int monthGap = Integer.parseInt(toDate.substring(4, 6)) - Integer.parseInt(fromDate.substring(4, 6));
        int dayGap = Integer.parseInt(toDate.substring(6, 8)) - Integer.parseInt(fromDate.substring(6, 8));

        monthGap = (yearGap * 12) + monthGap;
        if (!blnJustMonth) {
        	monthGap = monthGap + (dayGap >= 0 ? 0 : -1);
        }

        return monthGap;
    }
    
    /**
     * 년월 일자목록 얻기(양편)<br>
     * from년월 ~ to년월 사이의 양편 기준 일자 목록을 얻는다.<br>
     * 단, from~to 기간이 5년내에서만 사용 가능합니다.<br>
     * ex, String[] r = DateUtil.getDtIfLit("201110", "201203"); //r = {"201110", "201111", "201112", "201201", "201202",
     * "201203"}<br>
     * ex, String[] r = DateUtil.getDtIfLit("201203", "201205"); //r = {"201203", "201204", "201205"}<br>
     * ex, String[] r = DateUtil.getDtIfLit("201110", "201303"); //r = {"201110", "201111", "201112", "201201", "201202",
     * "201203", "201204", "201205", "201206", "201207", "201208", "201209", "201210", "201211", "201212", "201301", "201302",
     * "201303"}<br>
     * 
     * @param from from 년월(yyyyMM) - ex, "201110"
     * @param to to 년월(yyyyMM) - ex, "201203"
     * @return from~to 년월 목록(ex, {"201110", "201111", "201112", "201201", "201202", "201203"}
     */
    public static String[] getDtIfLit(String from, String to) {
        return getDtIfLit(from, to, DateUtil.MODE_BOTH_SIDES);
    }

    /**
     * 년월 일자목록 얻기(양편, 단편)<br>
     * from년월 ~ to년월 사이의 양편/단편 기준 일자 목록을 얻는다.<br>
     * 단, from~to 기간이 5년내에서만 사용 가능합니다.<br>
     * ex, String[] r = DateUtil.getDtIfLit("201110", "201203", DateUtil.MODE_BOTH_SIDES); //r = {"201110", "201111", "201112",
     * "201201", "201202", "201203"}<br>
     * ex, String[] r = DateUtil.getDtIfLit("201203", "201205", DateUtil.MODE_BOTH_SIDES); //r = {"201203", "201204", "201205"}<br>
     * ex, String[] r = DateUtil.getDtIfLit("201110", "201303", DateUtil.MODE_BOTH_SIDES); //r = {"201110", "201111", "201112",
     * "201201", "201202", "201203", "201204", "201205", "201206", "201207", "201208", "201209", "201210", "201211", "201212",
     * "201301", "201302", "201303"}<br>
     * <br>
     * ex, String[] r = DateUtil.getDtIfLit("201110", "201203", DateUtil.MODE_ONE_SIDE_INCLUDE_FROM); //r = {"201110", "201111",
     * "201112", "201201", "201202"}<br>
     * ex, String[] r = DateUtil.getDtIfLit("201203", "201205", DateUtil.MODE_ONE_SIDE_INCLUDE_FROM); //r = {"201203", "201204"}<br>
     * ex, String[] r = DateUtil.getDtIfLit("201110", "201303", DateUtil.MODE_ONE_SIDE_INCLUDE_FROM); //r = {"201110", "201111",
     * "201112", "201201", "201202", "201203", "201204", "201205", "201206", "201207", "201208", "201209", "201210", "201211",
     * "201212", "201301", "201302"}<br>
     * <br>
     * ex, String[] r = DateUtil.getDtIfLit("201110", "201203", DateUtil.MODE_ONE_SIDE_INCLUDE_TO); //r = {"201111", "201112",
     * "201201", "201202", "201203"}<br>
     * ex, String[] r = DateUtil.getDtIfLit("201203", "201205", DateUtil.MODE_ONE_SIDE_INCLUDE_TO); //r = {"201204", "201205"}<br>
     * ex, String[] r = DateUtil.getDtIfLit("201110", "201303", DateUtil.MODE_ONE_SIDE_INCLUDE_TO); //r = {"201111", "201112",
     * "201201", "201202", "201203", "201204", "201205", "201206", "201207", "201208", "201209", "201210", "201211", "201212",
     * "201301", "201302", "201303"}<br>
     * 
     * @param from from 년월(yyyyMM) - ex, "201110"
     * @param to to 년월(yyyyMM) - ex, "201203"
     * @param mode 양편단편모드({@link #MODE_BOTH_SIDES} : 양편, {@link #MODE_ONE_SIDE_INCLUDE_FROM} : from포함 단편,
     *            {@link #MODE_ONE_SIDE_INCLUDE_TO} : to포함 단편) - ex, DateUtil.MODE_BOTH_SIDES
     * @return from~to 년월 목록(ex, {"201110", "201111", "201112", "201201", "201202", "201203"}
     * 
     * @see #MODE_BOTH_SIDES
     * @see #MODE_ONE_SIDE_INCLUDE_FROM
     * @see #MODE_ONE_SIDE_INCLUDE_TO
     */
    public static String[] getDtIfLit(String from, String to, int mode) {
        String[] dtIfLit = null;

        int monthGap = getGapForMonth(from + "01", to + "01");

        if (monthGap < 0) { // from, to 월 차이가 - 인 경우
        	throw new BusinessRuntimeException("from(" + from + ")" + " 는(은) to(" + to + ") 보다 이후일 수 없습니다.");
        }

        if (mode == DateUtil.MODE_ONE_SIDE_INCLUDE_FROM || mode == DateUtil.MODE_ONE_SIDE_INCLUDE_TO) { // from포함단편, to포함단편인 경우
            if (monthGap == 0) { // from, to 월 차이가 0인 경우
            	throw new BusinessRuntimeException("단편 모드인 경우 같은 값인 from(" + from + "), to(" + to + ") 는(은) 입력할 수 없습니다.");
            }
        }

        int limitYear = 5;
        if (monthGap > 12 * limitYear) {
        	throw new BusinessRuntimeException("해당 유틸은 " + limitYear + "년 을(를) 초과 할 수 없습니다.");
        }

        int fromYear = Integer.parseInt(from.substring(0, 4));
        int fromMon = Integer.parseInt(from.substring(4));

        int toYear = Integer.parseInt(to.substring(0, 4));
        int toMon = Integer.parseInt(to.substring(4));

        if (fromYear == toYear) { // from, to 년도가 같은 경우
            int monGap = toMon - fromMon;

            dtIfLit = new String[monGap + 1];

            for (int i = 0; i < monGap + 1; i++) {
                StringBuffer sb = new StringBuffer();
                sb.append(fromYear).append(StringUtil.getFormatNumber(fromMon + i, "00"));

                dtIfLit[i] = sb.toString();
            }
        } else { // from, to 년도가 다른 경우
            int yearGap = toYear - fromYear;
            int fromMonGap = 12 - fromMon;
            int toMonGap = toMon;

            int gap = fromMonGap + (yearGap > 1 ? (yearGap - 1) * 12 : 0) + toMonGap;

            dtIfLit = new String[gap + 1];

            int idx = 0;
            for (int i = 0; i < yearGap + 1; i++) {
                if (i == 0) {

                    for (int k = 0; k < fromMonGap + 1; k++) {
                        StringBuffer sb = new StringBuffer();
                        sb.append(fromYear).append(StringUtil.getFormatNumber(fromMon + k, "00"));

                        dtIfLit[idx++] = sb.toString();
                    }
                } else {
                    if (yearGap > 1 && i < yearGap) {
                        for (int k = 0; k < yearGap - 1; k++) {
                            for (int m = 0; m < 12; m++) {
                                StringBuffer sb = new StringBuffer();
                                sb.append(fromYear + k + 1).append(StringUtil.getFormatNumber(m + 1, "00"));

                                dtIfLit[idx++] = sb.toString();
                            }
                        }
                    } else {
                        for (int k = 0; k < toMonGap; k++) {
                            StringBuffer sb = new StringBuffer();
                            sb.append(toYear).append(StringUtil.getFormatNumber(k + 1, "00"));

                            dtIfLit[idx++] = sb.toString();
                        }
                    }
                }

            }
        }

        String[] temp = null;
        switch (mode) {
        case DateUtil.MODE_ONE_SIDE_INCLUDE_FROM: // from포함 단편
            if (!ValidationUtil.isEmpty(dtIfLit)) {
                temp = new String[dtIfLit.length - 1];
                System.arraycopy(dtIfLit, 0, temp, 0, temp.length);
            }
            break;
        case DateUtil.MODE_ONE_SIDE_INCLUDE_TO: // to포함 단편
            if (!ValidationUtil.isEmpty(dtIfLit)) {
                temp = new String[dtIfLit.length - 1];
                System.arraycopy(dtIfLit, 1, temp, 0, temp.length);
            }
            break;
        }

        if (temp != null) {
            dtIfLit = temp;
        }

        return dtIfLit;
    }

    /**
     * 년월일 일자목록 얻기(양편)<br>
     * from년월일 ~ to년월일 사이의 양편 기준 일자 목록을 얻는다.<br>
     * 단, from~to 기간이 1년내에서만 사용 가능합니다.<br>
     * ex, String[] r = DateUtil.getDtLit("20120101", "20120105"); //r = {"20120101", "20120102", "20120103", "20120104",
     * "20120105"}<br>
     * ex, String[] r = DateUtil.getDtLit("20120129", "20120202"); //r = {"20120129", "20120130", "20120131", "20120201",
     * "20120202"}<br>
     * ex, String[] r = DateUtil.getDtLit("20111229", "20120102"); //r = {"20111229", "20111230", "20111231", "20120101",
     * "20120102"}<br>
     * ex, String[] r = DateUtil.getDtLit("20120101", "20120301"); //r = {"20120101", "20120102", "20120103", "20120104",
     * "20120105", "20120106", "20120107", "20120108", "20120109", "20120110", "20120111", "20120112", "20120113", "20120114",
     * "20120115", "20120116", "20120117", "20120118", "20120119", "20120120", "20120121", "20120122", "20120123", "20120124",
     * "20120125", "20120126", "20120127", "20120128", "20120129", "20120130", "20120131", "20120201", "20120202", "20120203",
     * "20120204", "20120205", "20120206", "20120207", "20120208", "20120209", "20120210", "20120211", "20120212", "20120213",
     * "20120214", "20120215", "20120216", "20120217", "20120218", "20120219", "20120220", "20120221", "20120222", "20120223",
     * "20120224", "20120225", "20120226", "20120227", "20120228", "20120229", "20120301"};<br>
     * 
     * @param from from 년월일(yyyyMMdd) - ex, "20120101"
     * @param to to 년월일(yyyyMMdd) - ex, "20120105"
     * @return from~to 년월일 목록 - ex, {"20120101", "20120102", "20120103", "20120104", "20120105"}
     */
    public static String[] getDtLit(String from, String to) {
        return getDtLit(from, to, 0);
    }

    /**
     * 년월일 일자목록 얻기(양편, 단편)<br>
     * from년월일 ~ to년월일 사이의 양편/단편 기준 일자 목록을 얻는다.<br>
     * 단, from~to 기간이 1년내에서만 사용 가능합니다.<br>
     * ex, String[] r = DateUtil.getDtLit("20120101", "20120105", DateUtil.MODE_BOTH_SIDES); //r = {"20120101", "20120102",
     * "20120103", "20120104", "20120105"}<br>
     * ex, String[] r = DateUtil.getDtLit("20120129", "20120202", DateUtil.MODE_BOTH_SIDES); //r = {"20120129", "20120130",
     * "20120131", "20120201", "20120202"}<br>
     * ex, String[] r = DateUtil.getDtLit("20111229", "20120102", DateUtil.MODE_BOTH_SIDES); //r = {"20111229", "20111230",
     * "20111231", "20120101", "20120102"}<br>
     * <br>
     * ex, String[] r = DateUtil.getDtLit("20120101", "20120105", DateUtil.MODE_ONE_SIDE_INCLUDE_FROM); //r = {"20120101",
     * "20120102", "20120103", "20120104" }<br>
     * ex, String[] r = DateUtil.getDtLit("20120129", "20120202", DateUtil.MODE_ONE_SIDE_INCLUDE_FROM); //r = {"20120129",
     * "20120130", "20120131", "20120201" }<br>
     * ex, String[] r = DateUtil.getDtLit("20111229", "20120102", DateUtil.MODE_ONE_SIDE_INCLUDE_FROM); //r = {"20111229",
     * "20111230", "20111231", "20120101" }<br>
     * <br>
     * ex, String[] r = DateUtil.getDtLit("20120101", "20120105", DateUtil.MODE_ONE_SIDE_INCLUDE_TO); //r = {"20120102",
     * "20120103", "20120104", "20120105"}<br>
     * ex, String[] r = DateUtil.getDtLit("20120129", "20120202", DateUtil.MODE_ONE_SIDE_INCLUDE_TO); //r = {"20120130",
     * "20120131", "20120201", "20120202"}<br>
     * ex, String[] r = DateUtil.getDtLit("20111229", "20120102", DateUtil.MODE_ONE_SIDE_INCLUDE_TO); //r = {"20111230",
     * "20111231", "20120101", "20120102"}<br>
     * <br>
     * 
     * @param from from 년월일(yyyyMMdd) - ex, "20120101"
     * @param to to 년월일(yyyyMMdd) - ex, "20120105"
     * @param mode 양편단편모드({@link #MODE_BOTH_SIDES} : 양편, {@link #MODE_ONE_SIDE_INCLUDE_FROM} : from포함 단편,
     *            {@link #MODE_ONE_SIDE_INCLUDE_TO} : to포함 단편) - ex, DateUtil.MODE_BOTH_SIDES
     * @return from~to 년월일 목록 - ex, {"20120101", "20120102", "20120103", "20120104", "20120105"}
     * 
     * @see #MODE_BOTH_SIDES
     * @see #MODE_ONE_SIDE_INCLUDE_FROM
     * @see #MODE_ONE_SIDE_INCLUDE_TO
     */
    public static String[] getDtLit(String from, String to, int mode) {
        String[] yyyyMMddLit = null;

        int dayGap = getGapForDay(from, to);

        if (dayGap < 0) { // from, to 일 차이가 - 인 경우
        	throw new BusinessRuntimeException("from(" + from + ")" + " 는(은) to(" + to + ") 보다 이후일 수 없습니다.");
        }

        if (mode == DateUtil.MODE_ONE_SIDE_INCLUDE_FROM || mode == DateUtil.MODE_ONE_SIDE_INCLUDE_TO) { // from포함단편, to포함단편인 경우
            if (dayGap == 0) { // from, to 일 차이가 0인 경우
            	throw new BusinessRuntimeException("단편 모드인 경우 같은 값인 from(" + from + "), to(" + to + ") 는(은) 입력할 수 없습니다.");
            }
        }

        int limitYear = 1; // 처리 최대 한도 년도(1년 = 365일)
        if (dayGap > 365 * limitYear) {
        	throw new BusinessRuntimeException("해당 유틸은 " + limitYear +"(=365*" + limitYear + ")년 을(를) 초과 할 수 없습니다.");
        }

        // from, to 년월 목록 얻기
        String fromYyyyMM = from.substring(0, 6); // from년월
        String toYyyyMM = to.substring(0, 6); // to년월

        String[] yyyyMMLit = null;
        if (fromYyyyMM.equals(toYyyyMM)) {
            yyyyMMLit = new String[]{fromYyyyMM};
        } else {
            yyyyMMLit = getDtIfLit(fromYyyyMM, toYyyyMM, MODE_BOTH_SIDES); // 무조건 양편 모드
        }

        // from, to 년월일 목록 얻기
        ArrayList<String> dtLit = new ArrayList<String>();
        int len = yyyyMMLit.length;
        for (int i = 0; i < len; i++) {
            String yyyyMM = yyyyMMLit[i];

            int startDay = 1;
            if (i == 0) { // 시작 월이면
                startDay = Integer.parseInt(from.substring(6));
            }

            int lastDay = -1;
            if (i == len - 1) { // 마지막 월이면
                lastDay = Integer.parseInt(to.substring(6));
            } else {
                lastDay = Integer.parseInt(getLastDay(yyyyMM).substring(6));
            }

            for (int k = startDay; k <= lastDay; k++) {
                int day = k;
                String dd = StringUtil.getFormatNumber(day, "00");

                dtLit.add(yyyyMM + dd);
            }
        }

        // 단편 모드 처리
        switch (mode) {
        case DateUtil.MODE_ONE_SIDE_INCLUDE_FROM: // from포함 단편
            dtLit.remove(dtLit.size() - 1);
            break;
        case DateUtil.MODE_ONE_SIDE_INCLUDE_TO: // to포함 단편
            dtLit.remove(0);
            break;
        }

        yyyyMMddLit = dtLit.toArray(new String[dtLit.size()]); // list -> array 변환

        return yyyyMMddLit;
    }    
    
    /**
     * 월 말일 구하기<br>
     * 기준일자(yyyyMMdd) 말일자 산출<br>
     * ex, String r = DateUtil.getLastDay("20110314"); //r="20110331"<br>
     * ex, String r = DateUtil.getLastDay("201103"); //r="20110331"<br>
     * 
     * @param strDate 기준일자(yyyyMM or yyyyMMdd)
     * @return 월 말일(yyyyMMdd)
     */
    public static String getLastDay(String strDate) {

        if (strDate.length() == 6)
            strDate = strDate + "01";

        Date date = getDateObject(strDate);

        Date lastDate = getLastDay(date);

        return getDate(lastDate, "yyyyMMdd");
    }

    /**
     * 월 말일 구하기<br>
     * 기준일자(date) 말일자 산출<br>
     * ex, date : "Tue Mar 01 00:00:00 KST 2011" 이면,<br>
     * Date r = DateUtil.getLastDay(date); //r="Thu Mar 31 00:00:00 KST 2011"<br>
     * 
     * @param date 기준일자
     * @return 월 말일 Date 객체
     */
    public static Date getLastDay(Date date) {
        Calendar calendar = getCalInstance();
        calendar.setTime(date);
        calendar.set(calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH), calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
        return calendar.getTime();
    }

    /**
     * 월 말일 구하기<br>
     * 기준일자(yyyyMMdd) 말일자 산출<br>
     * ex, String r = DateUtil.getLastDay(2011, 03); //r="20110331"<br>
     * 
     * @param year 년
     * @param month 월
     * @return 년월 말일(yyyyMMdd)
     */
    public static String getLastDay(int year, int month) {
        Calendar cal = getCalInstance();
        cal.set(year, month - 1, 1);
        
        cal.set(year, month - 1, cal.getActualMaximum(Calendar.DAY_OF_MONTH));
        return getDate(cal.getTime(), "yyyyMMdd");
    }    
    
    /**
     * Date 객체 얻기<br>
     * 문자열 일자(패턴 : yyyyMMdd)의 Date 객체를 구한다.<br>
     * ex, Date r = DateUtil.getDateObject("20110307"); //r=문자열 일자(20110307)에 대한 Date 객체<br>
     * 
     * @param strDate 문자열 일자(패턴 : yyyyMMdd)
     * @return 문자열 일자 값을 가진 Date 객체
     */
    public static Date getDateObject(String strDate) {

        return getDateObject(strDate, "yyyyMMdd");
    }

    /**
     * Date 객체 얻기<br>
     * 문자열 일자, 문자열 일자 패턴을 입력 받아 Date 객체를 구한다.<br>
     * ex, Date r = DateUtil.getDateObject("20110307", "yyyyMMdd"); //r=문자열 일자(20110307)에 대한 Date 객체<br>
     * 
     * @param strDate 문자열 일자
     * @param pattern 문자열 일자 패턴
     * @return 문자열 일자 값을 가진 Data 객체
     */
    public static Date getDateObject(String strDate, String pattern) {

        if (ValidationUtil.isEmpty(strDate)) {
        	throw new BusinessRuntimeException("문자열 일자(strDate) 는(은) 필수 입력항목입니다.");
        }
        if (ValidationUtil.isEmpty(pattern)) {
        	throw new BusinessRuntimeException("문자열 일자 패턴(pattern) 는(은) 필수 입력항목입니다.");
        }

        // SimpleDateFormat formatter = new SimpleDateFormat(pattern, java.util.Locale.KOREA);
        DateFormat formatter = ConcurrentDateFormatAccess.getDateFormat(pattern);

        Date date = null;
        try {
            date = formatter.parse(strDate);
        } catch (java.text.ParseException e) {
            throw new RuntimeException(e);
        }

        if (!formatter.format(date).equals(strDate)) {
        	throw new BusinessRuntimeException("일자(" + strDate + ")에 패턴(" + pattern + ") 적용이 유효하지 않습니다.");
        }
        return date;
    }    
    
    /**
     * yyyyMMdd 패턴 현재년월일 얻기<br>
     * yyyyMMdd 형식의 현재년월일을 얻는다.<br>
     * ex, getDate() ==> 20070816
     * 
     * @return 현재년월일(yyyyMMdd)
     */
    public static String getDate() {
        String format = "yyyyMMdd";
        Date date = new Date();

        return getDate(date, format);
    }

    /**
     * 패턴 형식 현재일자 얻기<br>
     * pattern 형식의 현재년월일시분초 등을 얻는다.<br>
     * ex, getDate("yyyy-MM-dd") ==> "2007-08-16"<br>
     * ex, getDate("yyyy-MM-dd HH:mm:ss") ==> "2007-08-16 02:10:30"
     * 
     * @param pattern java.text.SimpleDateFormat 패턴 사용
     * @return 패턴적용한 현재년월일
     */
    public static String getDate(String pattern) {
        Date date = new Date();

        return getDate(date, pattern);
    }

    /**
     * 입력 일자 패턴 적용하기<br>
     * yyyyMMdd 일자를 pattern 형식을 적용한 일자를 얻는다.<br>
     * ex, getDate("20050101", "yyyy-MM-dd") ==> 2005-01-01<br>
     * ex, getDate("20050101", "yyyy년MM월dd일") ==> 2005년01월01일<br>
     * 
     * @param yyyyMMdd yyyyMMdd 형식의 일자
     * @param pattern 적용하고 싶은 패턴
     * @return 해당 일자에 패턴을 적용한 일자
     */
    public static String getDate(String yyyyMMdd, String pattern) {
        Date date = getDateObject(yyyyMMdd, "yyyyMMdd");

        return getDate(date, pattern);
    }

    /**
     * 년, 월에 패턴 적용하기<br>
     * 년, 월을 받아 pattern을 적용한 년월을 얻는다.<br>
     * ex, String r = DateUtil.getDate(2011, 3, "yyyy-MM"); //r="2011-03"<br>
     * ex, getDate(2007, 3, "yyyyMM") ==> 200703<br>
     * 
     * @param year 년
     * @param month 월
     * @param pattern 패턴
     * @return pattern을 적용한 년월
     */
    public static String getDate(int year, int month, String pattern) {

        String mm = Integer.toString(month);
        if (month < 10)
            mm = "0" + mm;

        String yyyyMMdd = year + mm + "01";

        Date date = getDateObject(yyyyMMdd, "yyyyMMdd");

        return getDate(date, pattern);
    }

    /**
     * 년, 월, 일에 패턴 적용하기<br>
     * 년, 월, 일을 받아 pattern을 적용한 년월일을 얻는다.<br>
     * ex, String r = DateUtil.getDate(2011, 3, 14, "yyyy-MM-dd"); //r="2011-03-14"<br>
     * ex, getDate(2007, 3, 2, "yyyyMMdd") ==> 20070302<br>
     * ex, getDate(2007, 3, 2, "yyyyMM") ==> 200703<br>
     * 
     * @param year 년
     * @param month 월
     * @param day 일
     * @param pattern 패턴
     * @return pattern을 적용한 년월일
     */
    public static String getDate(int year, int month, int day, String pattern) {

        String mm = Integer.toString(month);
        if (month < 10)
            mm = "0" + mm;

        String dd = Integer.toString(day);
        if (day < 10)
            dd = "0" + dd;

        String yyyyMMdd = year + mm + dd;

        Date date = getDateObject(yyyyMMdd, "yyyyMMdd");

        return getDate(date, pattern);
    }

    /**
     * 입력 일자 패턴 적용하기<br>
     * ex, String r = DateUtil.getDate("2011-03-14", "yyyy-MM-dd", "yyyy/MM/dd"); //r="2011/03/14"<br>
     * 
     * @param strDate 문자열 일자
     * @param inPattern 문자열 일자 패턴
     * @param rtnPattern 리턴 패턴
     * @return 리턴 패턴이 적용된 문자열 일자
     */
    public static String getDate(String strDate, String inPattern, String rtnPattern) {
        Date date = getDateObject(strDate, inPattern);

        return getDate(date, rtnPattern);
    }

    /**
     * Date에 대한 패턴 적용 일자 얻기<br>
     * Date에 pattern 형식을 적용한 일자를 얻는다.<br>
     * ex, String r = DateUtil.getDate(DateUtil.getDateObject("20110314"), "yyyy-MM-dd"); //r="2011-03-14"<br>
     * ex, getDate(new Date(), "yyyy/MM/dd") ==> 2007/08/16 <br>
     * ex, String r = DateUtil.getDate(DateUtil.getTimestamp("20110314010101001"), "yyyy-MM-dd HH:mm:ss.SSS");<br>
     * //r="2011-03-14 01:01:01.001"<br>
     * 
     * @param date pattern을 적용하고 싶은 Date
     * @param pattern 적용하고 싶은 pattern
     * @return 해당 date에 패턴을 적용한 일자
     */
    public static String getDate(Date date, String pattern) {
        // SimpleDateFormat formatter = new SimpleDateFormat(pattern, java.util.Locale.KOREA);
        DateFormat formatter = ConcurrentDateFormatAccess.getDateFormat(pattern);
        return formatter.format(date);
    }    
    
    private static Calendar getCalInstance() {
    	Calendar cal = calThreadLocal.get();
    	if(cal == null) {
    		cal = Calendar.getInstance(Locale.KOREA);
    		calThreadLocal.set(cal);
    	}
    	return cal;
    }    
// [속도개선 Project   끝] 2017. 7. 11. 최범주
}
