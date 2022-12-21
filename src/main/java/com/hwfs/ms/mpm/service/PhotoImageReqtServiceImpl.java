package com.hwfs.ms.mpm.service;

import hone.online.xplatform.map.DataSetMap;

import java.io.File;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.ms.mpm.dao.PhotoImageReqtDAO;
import com.hwfs.sc.cmn.util.FileUtil;

 /**
 * 사진등록 정보 입력하는 PhotoImageReqt Service Implementation
 * 
 * @ClassName PhotoImageReqtServiceImpl.java
 * @Description PhotoImageReqtServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.27    강대성        최초생성
 * </pre>
 * @author FC종합전산구축 : 모바일 강대성
 * @since 2015.03.27
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ms/mpm/photoImageReqtService")
public class PhotoImageReqtServiceImpl extends DefaultServiceImpl implements PhotoImageReqtService {
	
	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** PhotoImageReqtDAO Bean 생성 */
	@Resource(name = "/ms/mpm/photoImageReqtDAO")
	private PhotoImageReqtDAO photoImageReqtDAO;
	

	/**
	 * 사진등록 정보 입력 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int saveList(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		String subDir = (String) list.get(0).get("subDir");
		String fullSubDir = "";
		String sourceFile = "";
		String targetFile = "";
		
		/* 01:CS진단관리(개선), 02:CS진단관리(점검), 03:위생점검관리(개선), 04:위생점검관리(점검), 05:협력업체위생관리(점검)
		   06:이벤트, 07:클레임, 08:LIMS, 09:안전점검관리(개선), 10:안전점검관리(점검) */
		fullSubDir = "/photo/" +subDir;		
		
		String fullPath = propertiesService.getString("global.imagerepository.path") +"/"+propertiesService.getString("ms.file.path") + fullSubDir;
		
		File saveFolder = new File(fullPath);

        // 디렉토리 생성
        if (!saveFolder.exists() || saveFolder.isFile()) {
            saveFolder.mkdirs();
        }
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			
			sourceFile = propertiesService.getString("global.ifisrepository.path") + "/" + rowData.get("saveFileNm");
			targetFile = fullPath +"/" + rowData.get("saveFileNm");
			
			rowData.put("relPath", fullSubDir);
			
			copyFile(sourceFile, targetFile);
			
			insRowCnt += photoImageReqtDAO.insert(rowData); 
			
		}
				
		return insRowCnt;
	}
	
	private void copyFile(String sourceFile, String targetFile) throws Exception {
        
		//파일저장소로 복사
		String copyFromFile = sourceFile;
		String copyTotargetFile = targetFile; 
		FileUtil.copyFile (copyFromFile, copyTotargetFile);
    }
}
