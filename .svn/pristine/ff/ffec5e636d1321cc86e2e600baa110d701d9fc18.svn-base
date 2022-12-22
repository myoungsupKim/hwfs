package com.hwfs.ls.cmn.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.URLDecoder;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.apache.commons.compress.archivers.zip.ZipArchiveEntry;
import org.apache.commons.compress.archivers.zip.ZipArchiveOutputStream;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.hwfs.sc.cmn.util.FileUtil;

/**
 * Lims에서 사용하는 Common Util Class
 *
 * @ClassName LimsUtil.java
 * @Description LimsUtil Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 2. 4.   jishoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jishoon
 * @since 2015. 2. 4.
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public final class LimsUtil {

    static Logger logger = LoggerFactory.getLogger(LimsUtil.class);

    private LimsUtil() {
    }

    /**
     * Object의 null을 체크하고 값이 없으면 초기값을 넘겨준다.
     *
     * @param o
     *            Null을 체크할 Object
     * @param defaultValue
     *            값이 없을 때 넘겨줄 초기값
     * @return Null을 체크하여 결과값을 리턴한다.
     */
    public static String checkNull(Object o, String defaultValue) {
        String returnValue = checkNull(o);
        if (returnValue.equals("")) {
            return defaultValue;
        } else {
            return returnValue;
        }
    }

    /**
     * Object의 null을 체크하고 값이 없으면 초기값을 넘겨준다.
     *
     * @param o
     *            Null을 체크할 Object
     * @param defaultValue
     *            값이 없을 때 넘겨줄 초기값
     * @return Null을 체크하여 결과값을 리턴한다.
     */
    public static int checkNull(Object o, int defaultValue) {
        String returnValue = checkNull(o);
        if (returnValue.equals("")) {
            return defaultValue;
        } else {
            return Integer.parseInt(returnValue);
        }
    }

    /**
     * Object의 null을 체크하고 값이 없으면 초기값을 넘겨준다.
     *
     * @param o
     *            Null을 체크할 Object
     * @param defaultValue
     *            값이 없을 때 넘겨줄 초기값
     * @return Null을 체크하여 결과값을 리턴한다.
     */
    public static double checkNull(Object o, double defaultValue) {
        String returnValue = checkNull(o);
        if (returnValue.equals("")) {
            return defaultValue;
        } else {
            return Double.parseDouble(returnValue);
        }
    }

    /**
     * 문자열의 null을 체크하고 값이 없으면 초기값을 넘겨준다.
     *
     * @param s
     *            Null을 체크할 문자열
     * @param defaultValue
     *            값이 없을 때 넘겨줄 초기값
     * @return Null을 체크하여 결과값을 리턴한다.
     */
    public static String checkNull(String s, String defaultValue) {
        String returnValue;
        if (s == null) {
            returnValue = defaultValue;
        } else if (s.equals("")) {
            returnValue = defaultValue;
        } else {
            returnValue = s.trim();
        }
        return returnValue;
    }

    /**
     * 문자열의 null을 체크하고 값이 없으면 초기값을 넘겨준다.
     *
     * @param s
     *            Null을 체크할 문자열
     * @param defaultValue
     *            값이 없을 때 넘겨줄 초기값
     * @return Null을 체크하여 결과값을 리턴한다.
     */
    public static int checkNull(String s, int defaultValue) {
        int returnValue;

        if (s == null) {
            returnValue = defaultValue;
        } else if (s.equals("")) {
            returnValue = defaultValue;
        } else {
            returnValue = Integer.valueOf(s);
        }
        return returnValue;
    }

    /**
     * 문자열의 null을 체크하고 값이 없으면 초기값을 넘겨준다. 한글이 깨지는경우가 발생하여 추가
     *
     * @param s
     * @param defaultValue
     * @param encoding
     * @return
     * @throws UnsupportedEncodingException
     */
    public static String checkNull(String s, String defaultValue, String encoding) throws UnsupportedEncodingException {
        String s1 = checkNull(s, defaultValue);
        return URLDecoder.decode(s1, encoding);
    }

    /**
     * 문자열의 null을 체크하고 값이 없으면 초기값을 넘겨준다. 한글이 깨지는경우가 발생하여 추가
     *
     * @param s
     * @param defaultValue
     * @param encoding
     * @return
     * @throws UnsupportedEncodingException
     */
    public static String checkNull(Object s, String defaultValue, String encoding) throws UnsupportedEncodingException {
        String s1 = checkNull(s, defaultValue);
        return URLDecoder.decode(s1, encoding);
    }

    /**
     * Object의 null을 체크한다.
     *
     * @param s
     *            Null을 체크할 문자열
     * @return Null을 체크하여 결과값을 리턴한다.
     */
    public static String checkNull(Object o) {
        Object returnValue = o;

        if (returnValue == null) {
            return "";
        } else if (returnValue instanceof String) {
            return (String) returnValue;
        } else if (returnValue instanceof Integer) {
            return returnValue.toString();
        } else if (returnValue instanceof BigDecimal) {
            return returnValue.toString();
        } else if (returnValue instanceof Double) {
            return returnValue.toString();
        } else if (returnValue instanceof String[]) {
            String[] value = (String[]) returnValue;
            return value[0];
        } else {
            return returnValue.toString();
        }
    }

    /**
     * 현재날짜를 다양한 포멧으로 리턴한다.
     *
     * @param type
     *            변경되어질 시간형식의 포멧
     *
     * 예) getDate("yyyyMMdd");
     * getDate("yyyyMMddHHmmss");
     * getDate("yyyy/MM/dd HH:mm:ss");
     * getDate("yyyy/MM/dd");
     * getDate("HHmm");
     */
    public static String getDate(String type) {
        String returnValue;
        if (type == null) {
            return "";
        }
        returnValue = new SimpleDateFormat(type, Locale.KOREA).format(new Date());
        return returnValue;
    }

    /**
     * 날짜(+시간)을 스트링으로 받어서 type 형태로 리턴한다.
     *
     * 예) formatDate("20030301","yyy/MM/dd") -> "2003/03/01"
     * formatDate("20030301","yyyy-MM-dd") -> "2003-03-01"
     * formatDate("2003030112","yyyy-MM-dd HH") -> "2003-03-01 12"
     * formatDate("200303011200","yyyy-MM-dd HH:mm ss") -> "2003-03-01 12:00 00"
     * formatDate("20030331115959","yyyy-MM-dd-HH-mm-ss") -> "2003-03-31-11-59-59"
     *
     * @param date
     *            날짜포멧으로 변경될 문자열
     * @param type
     *            변경되어질 시간형식의 포멧
     * @return 변경되어진 문자열
     */
    public static String formatDate(String date, String type) throws Exception {
        if (date == null || type == null) {
            return null;
        }
        String returnValue;
        int targetLength = date.length();

        if (targetLength >= 8) { // 날짜
            int year;
            int month;
            int day;
            int hour = 0;
            int min = 0;
            int sec = 0;

            year = Integer.parseInt(date.substring(0, 4));
            month = Integer.parseInt(date.substring(4, 6)); // month 는 Calendar 에서 0 base 으로 작동하므로 1 을 빼준다.
            day = Integer.parseInt(date.substring(6, 8));
            if (targetLength == 12) { // 날짜+시간
                hour = Integer.parseInt(date.substring(8, 10));
                min = Integer.parseInt(date.substring(10, 12));
            } else if (targetLength == 14) { // 날짜+시간
                hour = Integer.parseInt(date.substring(8, 10));
                min = Integer.parseInt(date.substring(10, 12));
                sec = Integer.parseInt(date.substring(12, 14));
            }
            Calendar cal = Calendar.getInstance();
            cal.set(year, month - 1, day, hour, min, sec);
            returnValue = new SimpleDateFormat(type, Locale.KOREA).format(cal.getTime());
        } else {
            returnValue = "";
        }

        return returnValue;
    }

    /**
     * 현재일로 부터 해당 구분에 따라 월,일 등을 더한다.
     *
     * @param type
     *            리턴되어질 날짜 형식
     * @param gubn
     *            더하고자 하는 날짜구분
     * @param rec
     *            더하고자 하는 수
     * @return 계산되어진 날짜형식의 문자열
     */
    public static String getDateAdd(String type, String gubn, int rec) throws Exception {
        String returnValue;
        if (type == null)
            return "";

        Calendar cal = Calendar.getInstance();
        if (gubn.equals("month")) {
            cal.add(Calendar.MONTH, rec);
        }
        if (gubn.equals("date")) {
            cal.add(Calendar.DATE, rec);
        }
        if (gubn.equals("hour")) {
            cal.add(Calendar.HOUR_OF_DAY, rec);
        }
        if (gubn.equals("minute")) {
            cal.add(Calendar.MINUTE, rec);
        }
        if (gubn.equals("second")) {
            cal.add(Calendar.SECOND, rec);
        }
        returnValue = new SimpleDateFormat(type, Locale.KOREA).format(cal.getTime());

        return returnValue;
    }

    /**
     * 폴더가 없으면 폴더 생성
     *
     * @param filePath
     */
    public static void makeFolder(String filePath) {
        File dirPath = new File(filePath);
        if (!dirPath.exists()) {
            dirPath.mkdir();
        }
    }

    /**
     * 폴더가 있으면 폴더 삭제
     *
     * @param filePath
     */
    public static void deleteFoler(String filePath) {
        File dirPath = new File(filePath);
        if (dirPath.exists()) {
            dirPath.delete();
        }
    }

    /**
     * 파일이 있는지 여부 체크
     *
     * @param filePath
     */
    public static boolean isExistsFile(String filePath) {
        boolean isExists;
        File dirPath = new File(filePath);
        if (dirPath.exists()) {
            isExists = true;
        } else {
            isExists = false;
        }
        return isExists;
    }

    /**
     * 파일이 있으면 파일 삭제
     *
     * @param filePath
     */
    public static void deleteFile(String filePath) {
        File dirPath = new File(filePath);
        if (dirPath.exists()) {
            dirPath.delete();
        }
    }

    /**
     * Full경로 파일명에서 확장자만 추출
     *
     * @param fullPachFilename
     * @return
     */
    public static String getFileExt(String fullPachFilename) {
        if ("".equals(LimsUtil.checkNull(fullPachFilename)))
            return "";

        int ext = fullPachFilename.lastIndexOf('.');
        int length = fullPachFilename.length();
        String filename = fullPachFilename.substring(ext + 1, length);

        return filename;
    }

    /**
     * 공백 및 특수문자 제거
     *
     * @param s
     * @return
     */
    public static String speciaLettersRemove(String s) {
        return s.replaceAll("[\"'\\{\\}\\[\\]/?.,;:|\\)\\(*~`!^\\-_+<>@#$%^\\\\=\\p{Space}]", "");
    }

    /**
     * 문자열에서 특정갯수만큼 자른다.(갯수만큼 잘라서 가져온다.)
     *
     * @param s
     *            특정부분을 자를 문자열
     * @param start
     *            자를 시작위치
     * @param count
     *            자를 문자갯수
     * @return 시작위치에서 특정갯수만큼 잘려진 string 값
     */
    public static String midString(String s, int start, int count) throws Exception {
        String returnValue;
        if (s == null)
            return "";

        if (start >= s.length()) {
            returnValue = "";
        } else if (s.length() < start + count) {
            returnValue = s.substring(start, s.length());
        } else {
            returnValue = s.substring(start, start + count);
        }

        return returnValue;
    }

    /**
     * 문자열의 오른쪽부터 특정갯수만큼 문자를 자른다.
     *
     * @param s
     *            특정부분을 자를 문자열
     * @param count
     *            자를 문자갯수
     * @return 오른쪽부터 특정갯수만큼 잘려진 string 값
     */
    public static String rightString(String s, int count) throws Exception {
        String returnValue;

        if (s == null)
            return "";
        if (s.equals(""))
            return "";

        if (count == 0) {// 갯수가 0 이면 공백을
            returnValue = "";
        } else if (count > s.length()) { // 문자열 길이보다 크면 문자열 전체를
            returnValue = s;
        } else {
            returnValue = s.substring(s.length() - count, s.length()); // 오른쪽 count 만큼 리턴
        }

        return returnValue;
    }

    /**
     * 문자열의 왼쪽부터 특정갯수만큼 문자를 자른다.
     *
     * @param s
     *            특정부분을 자를 문자열
     * @param count
     *            자를 문자갯수
     * @return 왼쪽부터 특정갯수만큼 잘려진 string 값
     */
    public static String leftString(String s, int count) throws Exception {
        String returnValue;
        if (s == null)
            return "";
        if (s.equals(""))
            return "";

        if (count == 0) { // 갯수가 0 이면 공백을
            returnValue = "";
        } else if (count > s.length()) { // 문자열 길이보다 크면 문자열 전체를
            returnValue = s;
        } else {
            returnValue = s.substring(0, count); // 왼쪽 count 만큼 리턴
        }

        return returnValue;
    }

    /**
     * 구분자 포함 코드성 데이터 문자열을 List객체로 변환
     *
     * @param s
     * @param token
     * @return
     * @throws Exception
     */
    public static List<String> codeConvertStringToList(String s, String token) throws Exception {
        String[] strInputValue = null;
        if (s == null)
            return null;
        if (s.equals(""))
            return null;

        List<String> ls = new ArrayList<String>();
        if (!LimsUtil.checkNull(s).equals("")) {
            strInputValue = s.split(token);
            ls = Arrays.asList(strInputValue);
            /*for (int i = 0; i < strInputValue.length; i++) {
                ls.add(strInputValue[i]);
            }*/
        }
        return ls;
    }

    /**
     * blob 항목을  file로 저장 한다.
     *
     * @param srcFile
     * @param bytBuf
     * @throws Exception
     */
    public static void saveBlobToFile(String srcFile, byte[] bytBuf) throws Exception {
        FileOutputStream fos = null;

        try {
            fos = new FileOutputStream(new File(srcFile));
            if (fos != null) {
                fos.write(bytBuf, 0, bytBuf.length);
            }
            fos.flush();
            //fos.close();
        } catch (Exception ex) {
            logger.error(ex.getMessage());
        } finally {
            if (fos != null) {
                try {
                    fos.close();
                    fos = null;
                } catch (Exception e) {
                    logger.error(e.getMessage());
                }
            }
        }
    }

    /**
     * 성적서 pdf 파일들을 압축
     *
     * @param realPath
     * @param reqNum
     * @throws Exception
     */
    public static void createInsptRptZip(String realPath, String reqNum, int publishCnt) throws Exception {
        // 의뢰번호를 파일명으로 하는 zip 파일을 생성한다.
        String output = realPath + reqNum + ".zip";
        if (publishCnt > 1) {
            // 성적서 재발행건은 원본은 놔두고 따로 묶는다.
            output = realPath + reqNum + "_reissue.zip";
        }
        FileOutputStream fos = null;
        BufferedOutputStream bos = null;
        ZipArchiveOutputStream zos = null;
        File sourceFile = new File(realPath);
        String sourcePath = realPath;

        try {
            fos = new FileOutputStream(output); // FileOutputStream
            bos = new BufferedOutputStream(fos); // BufferedStream
            zos = new ZipArchiveOutputStream(bos); // ZipOutputStream
            zos.setLevel(8); // 압축 레벨 - 최대 압축률은 9, 디폴트 8
            zos.setEncoding("EUC-KR");
            LimsUtil.zipEntry(sourceFile, sourcePath, reqNum, zos); // Zip 파일 생성
            zos.finish(); // ZipOutputStream finish
        } finally {
            if (zos != null) {
                zos.close();
            }
            if (bos != null) {
                bos.close();
            }
            if (fos != null) {
                fos.close();
            }
        }
    }

    /**
     * 의뢰번호를 파일명으로 하는 성적서 pdf 파일들을 압축
     *
     * @param sourceFile
     * @param sourcePath
     * @param reqNum
     * @param zos
     * @throws Exception
     */
    public static void zipEntry(File sourceFile, String sourcePath, String reqNum, ZipArchiveOutputStream zos) throws Exception {
        int bufferSize = 1024 * 2;

        // sourceFile 이 디렉토리인 경우 하위 파일 리스트 가져와 재귀호출
        if (sourceFile.isDirectory()) {
            if (sourceFile.getName().equalsIgnoreCase(".metadata")) { // .metadata 디렉토리 return
                return;
            }
            File[] fileArray = sourceFile.listFiles(); // sourceFile 의 하위 파일 리스트
            for (int i = 0; i < fileArray.length; i++) {
                // 의뢰번호가 같은 파일을 압축한다.
                if (fileArray[i].getName().indexOf(reqNum) != -1 && fileArray[i].getName().indexOf(".zip") == -1) {
                    LimsUtil.zipEntry(fileArray[i], sourcePath, reqNum, zos); // 재귀 호출
                }
            }
        } else { // sourcehFile 이 디렉토리가 아닌 경우
            BufferedInputStream bis = null;
            try {
                String sFilePath = sourceFile.getPath();
                //String zipEntryName = sFilePath.substring(sourcePath.length() + 1, sFilePath.length());
                String zipEntryName = sFilePath.substring(sourcePath.length(), sFilePath.length());

                bis = new BufferedInputStream(new FileInputStream(sourceFile));
                ZipArchiveEntry zentry = new ZipArchiveEntry(zipEntryName);
                zos.putArchiveEntry(zentry);
                byte[] buffer = new byte[bufferSize];
                int cnt = 0;
                while ((cnt = bis.read(buffer, 0, bufferSize)) != -1) {
                    zos.write(buffer, 0, cnt);
                }
                zos.closeArchiveEntry();
            } finally {
                if (bis != null) {
                    bis.close();
                }
            }
        }
    }


    /**
     * pdf파일들을 삭제 한다.
     *
     * @param realPath
     * @param reqNum
     * @param publishCnt
     * @throws Exception
     */
    public static void deletePdfFile(String realPath) throws Exception {
        File sourceFile = new File(realPath);
        LimsUtil.deletePdfFileEntry(sourceFile); // pdf파일 삭제
    }

    /**
     * 성적서 pdf파일들을 삭제
     *
     * @param sourceFile
     * @param sourcePath
     * @param reqNum
     * @param zos
     * @throws Exception
     */
    public static void deletePdfFileEntry(File sourceFile) throws Exception {
        if (sourceFile.isDirectory()) {
            if (sourceFile.getName().equalsIgnoreCase(".metadata")) { // .metadata 디렉토리 return
                return;
            }
            File[] fileArray = sourceFile.listFiles(); // sourceFile 의 하위 파일 리스트
            for (int i = 0; i < fileArray.length; i++) {
                if (fileArray[i].getName().indexOf(".pdf") != -1) {
                    File file = fileArray[i];
                    FileUtil.deleteFile(file.getPath());
                }
            }
        }
    }

    /**
     * 숫자와 '.'가 아닌문자의 경우 문자를제외후 double형으로 리턴한다.
     *
     * @param str
     * @return double - 사용 예 String num = LimsUtil.stringToNumber("####1163.51244***123#####") 결과 : 1163.51244123
     */
    public static double stringToNumber(String str) {
        StringBuffer sb = new StringBuffer();
        String number = "1234567890.";

        for (int i = 0; i < str.length(); i++) {
            if (number.indexOf(str.charAt(i)) > -1) {
                sb.append(str.charAt(i));
            }
        }

        return Double.parseDouble(sb.toString());
    }

    /**
     * 금액에 콤마를 삽입한다.
     *
     * @param amt
     *            변환할 금액
     * @param dec
     *            소수자리
     * @return String
     *         <p>
     *
     *         <pre>
     *  - 사용 예
     *        String date = LimsUtil.getCommaNumber(123456.123, "###,##0.00")
     *  결과 : 123,456.123
     * </pre>
     */
    public static String getCommaNumber(double amt, String frm) {
        DecimalFormat df = new DecimalFormat(frm);
        return df.format(amt);
    }

    /**
     * 전화번호 포맷 설정
     *
     * @param phoneNo
     * @return
     */
    public static String phoneFormat(String phoneNo) {
        if (phoneNo.length() == 0) {
            return phoneNo;
        }

        String strTel = phoneNo;
        String[] strDDD = { "02", "031", "032", "033", "041", "042", "043", "051", "052", "053", "054", "055", "061", "062", "063", "064", "010", "011", "012", "013", "015", "016", "017", "018", "019", "070" };

        if (strTel.length() < 9) {
            return strTel;
        } else if (strTel.substring(0, 2).equals(strDDD[0])) {
            strTel = strTel.substring(0, 2) + '-' + strTel.substring(2, strTel.length() - 4) + '-' + strTel.substring(strTel.length() - 4, strTel.length());
        } else {
            //for (int i = 1; i < strDDD.length; i++) {
            //if (strTel.substring(0, 3).equals(strDDD[i])) {
            strTel = strTel.substring(0, 3) + '-' + strTel.substring(3, strTel.length() - 4) + '-' + strTel.substring(strTel.length() - 4, strTel.length());
            //}
            //}
        }
        return strTel;
    }

}
