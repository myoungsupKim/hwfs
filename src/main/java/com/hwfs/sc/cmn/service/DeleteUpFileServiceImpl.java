package com.hwfs.sc.cmn.service;

import java.io.File;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.util.FileUtil;

/**
 * File Upload 시 생기는 임시 파일을 주기적으로 삭제하는 서비스
 * @ClassName DeleteUpFileServiceImpl.java
 * @Description DeleteUpFileServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.02.01.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.02.01.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/cmn/deleteUpFileService")
public class DeleteUpFileServiceImpl extends DefaultServiceImpl implements DeleteUpFileService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/**
	 * File Upload 시 생기는 임시 파일을 주기적으로 삭제한다.
	 * <pre>
	 * - DeleteUpFileSchdJob에 의해 주기적으로 호출된다.
	 * - global.fileupload.path, global.filedownload.path가 삭제 대상이다.
	 * </pre>
	 * @throws Exception
	 */
	public void deleteUpFile () throws Exception {
        try {
        	//File Upload 임시 파일을 삭제
	        String strDir = propertiesService.getString("global.fileupload.path", "");
	        deleteTempFile (strDir);
	 
	        //File Download 임시 파일을 삭제
	        strDir = propertiesService.getString("global.filedownload.path", "");
	        deleteTempFile (strDir);
	        
        }catch (Exception e){
            logger.error("************deleteUpFile Exception : ", e);
        }
    }
	
    /**
     * 원본 디렉토리 이하의 모든 파일에서 기준 시간이 지난 파일을 삭제한다.
     * <pre>
     * - 서브 디렉토리도 처리한다.
     * - 기준 시간은 현재시간의 0분으로 한다.
     * </pre>
     *
     * @param strSrcDir 원본 디렉토리
     * @throws Exception
     */
	private void deleteTempFile (String strSrcDir) throws Exception {
		if (strSrcDir.equals("")) {
			logger.error ("등록된 경로가 아닙니다.({})", strSrcDir);
			return;
		}
		
		//소스 경로
		File dir = new File(strSrcDir);
		if(!dir.exists()) {
			logger.error ("경로가 존재 하지 않습니다.({})", strSrcDir);
			return ;
		}
		
        int intTotalCnt = 0;	//삭제 건수
        
        // 탐색할 파일을 저장할 리스트
		ArrayList<File> files = new ArrayList<File>();
		
		// 파일 목록을 탐색한다.
		findAllFiles(files, dir);		
		
		//기준시간을 얻는다. 현재시간 0분으로 한다.
		Calendar calendar = Calendar.getInstance();
		calendar.set(java.util.Calendar.MINUTE, 0);
		long lngBaseTime = calendar.getTimeInMillis();
		
		//File 수정시간을 위한 Date : 테스트용
		//Date date = new Date();

	    // 탐색한 파일을 하나씩 처리한다.
		for(File f : files) {
			if (!f.exists())
				continue;
			
			//기준시간이 지난 파일을 대상으로 한다.
			if (f.lastModified() <= lngBaseTime) {
				String strSrcFile = f.getPath();
				//date.setTime(f.lastModified());
				//log.debug(strSrcFile + "," + date + "," + f.lastModified() + "," + lngBaseTime);
				FileUtil.deleteFile(strSrcFile);
				intTotalCnt++;
			}
		}
        logger.debug ("************deleteUpFile Summary : {} files are deleted in {}!", intTotalCnt, strSrcDir);
	}

	/**
	 * 
	 * 디렉토리 이하의 모든 파일을 arraylist에 추가한다.
	 * <pre>
	 * - 만약 검색된 부분이 디렉토리라면 하위 폴더를 탐색한다.
	 * </pre>
	 *
	 * @param files 파일 목록
	 * @param dir 대상 디렉토리 
	 */
	private void findAllFiles(List<File> files, File dir) {
		if(dir.isDirectory()) {
			if (dir.getName().equalsIgnoreCase(".svn")) return;	//.svn은 대상 제외
			File[] children = dir.listFiles();
			for(File f : children) {
				// 재귀 호출 사용                
				// 하위 폴더 탐색 부분                
				findAllFiles(files,f);            
			}        
		} else {
			files.add(dir);        
		}
	}

}