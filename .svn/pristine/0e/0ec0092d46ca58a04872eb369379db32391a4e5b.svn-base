package com.hwfs.ms.mef.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.util.DateUtil;
import com.hwfs.cmn.util.StringUtil;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.cmn.service.AttachFileService;
import com.hwfs.sc.cmn.util.FileUtil;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.ms.mef.dao.FileUploadEfoodistDAO;
import com.hwfs.ms.mef.dto.FileUploadEfoodistDTO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * E-FOODIST등록관리(파일첨부)하는 FileUploadEfoodist Service Implementation
 * 
 * @ClassName FileUploadEfoodistServiceImpl.java
 * @Description FileUploadEfoodistServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.17    강대성        최초생성
 * </pre>
 * @author FC종합전산구축 : E-FOODIST(런타임,모바일) 강대성
 * @since 2015.03.17
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ms/mef/fileUploadEfoodistService")
public class FileUploadEfoodistServiceImpl extends DefaultServiceImpl implements FileUploadEfoodistService {
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());
	
	/** AttachFile Service Bean 생성 */
	@Resource(name = "/sc/cmn/attachFileService")
	private AttachFileService attachFileService;

	/** Guide Sample DAO */
	@Resource(name="/ms/mef/fileUploadEfoodistDAO")
	private FileUploadEfoodistDAO fileUploadEfoodistDAO;
	

	/**
	 * E-FOODIST등록관리(파일첨부) 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	@Override
	public RecordSet selectList(Map<String, Object> parameter) throws Exception {
		return fileUploadEfoodistDAO.selectList(parameter);
	}
	
	/**
	 * E-FOODIST등록관리(파일첨부) 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	@Override
	public RecordSet selectDetailList(Map<String, Object> parameter) throws Exception {
		return fileUploadEfoodistDAO.selectDetailList(parameter);
	}
	
	/**
	 * E-FOODIST등록관리(파일첨부) 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	@Override
	public RecordSet selectPopList(Map<String, Object> parameter) throws Exception {
		return fileUploadEfoodistDAO.selectPopList(parameter);
	}

	/**
	 * E-FOODIST등록관리(파일첨부) DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings({ "unchecked", "unused" })
	public String saveAttachFile(DataSetMap list, DataSetMap listFile) throws Exception {
		String strRefSeq = "";	//첨부참조일련번호
		String imgFileNm = (String) list.get(0).get("imgFileNm");
		String strUploadPath = propertiesService.getString("global.imagerepository.path");
		String fullPath = strUploadPath +"/"+propertiesService.getString("ms.file.path") +"/mef";
		String imgFilePath = "upload"+propertiesService.getString("ms.file.path") +"/mef/" +imgFileNm;
		
		String sourceFile = "";
		String targetFile = "";
		
		File saveFolder = new File(fullPath);

        // 디렉토리 생성
        if (!saveFolder.exists() || saveFolder.isFile()) {
            saveFolder.mkdirs();
        }
		
		//첨부파일 처리 : 업무별 저장소의 상대패스를 파라미터로 전달해야 한다.
		strRefSeq = attachFileService.save(listFile, propertiesService.getString("ms.file.path") +"/mef", false, true, true);
		
		for (int k = 0; k < listFile.size(); k++) {
			Map<String, Object> mapFile = listFile.get(0);
			
			sourceFile = propertiesService.getString("global.filerepository.path") + mapFile.get("relPath") + "/" + mapFile.get("saveFileNm");
			targetFile = fullPath +"/" + mapFile.get("saveFileNm") +".pdf";
		}
		
		
		int intCnt=0;
		//데이터 저장 처리
		for (int i = 0; i < list.size(); i++) {
			Map<String, Object> map = list.get(i);
			//첨부참조일련번호 설정
			if (!strRefSeq.equals(""))
			{
				map.put("refSeq", strRefSeq);	
			}
			
			map.put("imgFilePath", imgFilePath);	
			
			int rowType = ((Integer) map.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			
			int cnt = fileUploadEfoodistDAO.saveChk(map);			
			
			if ( rowType == DataSet.ROW_TYPE_INSERTED ){
				
				if(cnt != 0){
					
					throw processException("ls.dataChkDup"); //중복되는 데이터가 있습니다.
				}
				
				intCnt += fileUploadEfoodistDAO.insert(map);
				
				//blob 칼럼을 파일로 저장하는 예이며, 실제로는 테이블의 BLOB 칼럼으로 저장하면 된다.
				byte[] blob = (byte[])list.get(0).get("imgFile");
				
				saveBlobToFile(fullPath +"/" +imgFileNm , blob);				
				
			}else if (rowType == DataSet.ROW_TYPE_UPDATED){

				intCnt += fileUploadEfoodistDAO.update(map);
				
				//blob 칼럼을 파일로 저장하는 예이며, 실제로는 테이블의 BLOB 칼럼으로 저장하면 된다.
				byte[] blob = (byte[])list.get(0).get("imgFile");
				
				saveBlobToFile(fullPath +"/" +imgFileNm , blob);				
				
			}else if (rowType == DataSet.ROW_TYPE_DELETED){
				intCnt += fileUploadEfoodistDAO.delete(map);
			}
		}		
		
		return strRefSeq;
	}
	
	private void saveBlobToFile(String srcFile, byte[] bytBuf) throws Exception {
        FileOutputStream fos = null;
        try {
            fos = new FileOutputStream(new File(srcFile));
            int i = 0;
            if (fos != null) {
            	fos.write(bytBuf, 0, bytBuf.length);
            }

        } catch (Exception ex) {
        	logger.error(ex.getMessage());
        } finally {
        	if (fos != null){
                try {
                    fos.close();
                } catch (Exception e) {
                    logger.error(e.getMessage());
                }
            }
        }
    }
	
}
