package com.hwfs.fm.fms.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.io.File;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;


import com.hwfs.cmn.crypto.aria.ARIACryptoServiceImpl;
import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.util.DateUtil;
import com.hwfs.sc.cmn.service.AttachFileService;
import com.hwfs.sc.cmn.util.FileUtil;
import com.hwfs.sc.cmn.util.StringUtil;
import com.hwfs.fm.fms.dao.PaperMgmtDAO;
import com.tobesoft.xplatform.data.DataSet;


// MIG  관련
import com.hwfs.cmn.idgen.SequenceIdGenService;
import com.hwfs.cmn.idgen.UUIdGenService;
import com.hwfs.sc.cmn.dao.AttachFileDAO;
import com.hwfs.sc.cmn.dto.AttachFileDTO;

 /**
 * 관련서류 및 첨부파일을 관리하는 PaperMgmt Service Implementation
 * 
 * @ClassName PaperMgmtServiceImpl.java
 * @Description PaperMgmtServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.05    최성연        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최성연
 * @since 2015.03.05
 * @version 1.0 
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fm/fms/paperMgmtService")
public class PaperMgmtServiceImpl extends DefaultServiceImpl implements PaperMgmtService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());
	
	
	/** AttachFile Service Bean 생성 */
	@Resource(name = "/sc/cmn/attachFileService")
	private AttachFileService attachFileService;
	
	/** PaperMgmtDAO Bean 생성 */
	@Resource(name = "/fm/fms/paperMgmtDAO")
	private PaperMgmtDAO paperMgmtDAO;

    /** UUIdGenService */
    @Resource(name = "idGenUUIdService")
    protected UUIdGenService idGenUUIdService;

	/** File Attach DB Sequence idGnrService */
	@Resource(name="idGenSequenceAtchFile") 
	private SequenceIdGenService idGenSequenceAtchFile;

    /** CryptoService */
    @Resource(name = "ariaCryptoService")
    protected ARIACryptoServiceImpl cryptoService;

	/** AttachFileDAO */
    @Resource(name="/sc/cmn/attachFileDAO")
    private AttachFileDAO attachFileDAO;
	
	/** FMS AttachFile Service Bean 생성 */
	@Resource(name = "/fm/fms/paperMgmtService")
	private PaperMgmtService paperMgmtService;
	

	/**
	 * 서류관리 목록을 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return paperMgmtDAO.selectList(mapParam);
	}
	public RecordSet selectMigList(Map<String, Object> mapParam) throws Exception {
		return paperMgmtDAO.selectMigList(mapParam);
	}
	public RecordSet selectPath(Map<String, Object> mapParam) throws Exception {
		return paperMgmtDAO.selectPath(mapParam);
	}

	/**
	 * 문서정보 DATA를 조회한다.(1 ROW)
	 * <pre>
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	@Override
	public RecordSet selectDoc(Map<String, Object> mapParam) throws Exception {
		return paperMgmtDAO.selectDoc(mapParam);
	}


	
    /**
     * XPLATFORM DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
     * <pre>
     * - 데이터와 첨부파일을 함께 처리한다.
     * </pre>
     * 
     * @param list 데이터
     * @parma listFile 첨부파일 정보
     * @param loginDTO 로그인 DTO
     * @return 첨부참조일련번호
     * @throws Exception
     */
	@SuppressWarnings({ "unchecked", "unused" })
	public String saveDoc(DataSetMap list, DataSetMap listFile) throws Exception {
		String strRefSeq = "";	//첨부참조일련번호
		String strPath = "";
		
		//첨부파일 처리 : 업무별 저장소의 상대패스를 파라미터로 전달해야 한다., 문서정보는 /fm/fms/doc/업장
		//strRefSeq = attachFileService.save(listFile, propertiesService.getString("fm.file.path"), false);
		//데이터 저장 처리
		strPath = propertiesService.getString("fm.file.path");
		for (int i = 0; i < list.size(); i++) {
			Map<String, Object> map = list.get(i);
			strPath =  strPath + "/fms/doc/" + map.get("upjang");
			break;
		}
				
		// DEBUG --- 1
		logger.debug(" ** 파일저장경로");
		logger.debug(" - strPath => " + strPath);
		
		// 암호화 적용
		strRefSeq = attachFileService.save(listFile, strPath, true);
		
		int intCnt=0;
		//데이터 저장 처리
		for (int i = 0; i < list.size(); i++) {
			Map<String, Object> map = list.get(i);
			//첨부참조일련번호 설정
			if (!strRefSeq.equals(""))
				map.put("refSeq", strRefSeq);

			int rowType = ((Integer) map.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			if ( rowType == DataSet.ROW_TYPE_INSERTED ){
				intCnt += paperMgmtDAO.insertDoc(map);
			}else if (rowType == DataSet.ROW_TYPE_UPDATED){
				intCnt += paperMgmtDAO.updateDoc(map);
			}else if (rowType == DataSet.ROW_TYPE_DELETED){
				intCnt += paperMgmtDAO.deleteDoc(map);
			}else if (!strRefSeq.equals("")) {
				//(주의)나머지 rowType인 경우 첨부참조일련번호가 새로 채번된 경우 Update하도록 함 
				intCnt += paperMgmtDAO.updateDoc(map);
			}
		}
		
		return strRefSeq;
	}
	

	
	
    /**
     * XPLATFORM DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다. : 자료이관용
     * <pre>
     * - 데이터와 첨부파일을 함께 처리한다.
     * </pre>
     * 
     * @param list 데이터
     * @parma listFile 첨부파일 정보
     * @param loginDTO 로그인 DTO
     * @return 첨부참조일련번호
     * @throws Exception
     */
	@SuppressWarnings({ "unchecked", "unused" })
	public String saveMig(DataSetMap list, DataSetMap listFile) throws Exception {
		String strRefSeq = "";	//첨부참조일련번호
		
		//첨부파일 처리 : 업무별 저장소의 상대패스를 파라미터로 전달해야 한다. : /fm
		//strRefSeq = attachFileService.save(listFile, propertiesService.getString("fm.file.path"), false);
		// 암호화 적용
		strRefSeq = paperMgmtService.saveFile(listFile, propertiesService.getString("fm.file.path"), true);
		
		int intCnt=0;
		//데이터 저장 처리
		for (int i = 0; i < list.size(); i++) {
			Map<String, Object> map = list.get(i);
			//첨부참조일련번호 설정
			if (!strRefSeq.equals(""))
				map.put("refSeq", strRefSeq);

			int rowType = ((Integer) map.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			
			if ( rowType == DataSet.ROW_TYPE_INSERTED ){
				intCnt += paperMgmtDAO.insertDoc(map);
			}else if (rowType == DataSet.ROW_TYPE_UPDATED){
				intCnt += paperMgmtDAO.updateDoc(map);
			}else if (rowType == DataSet.ROW_TYPE_DELETED){
				intCnt += paperMgmtDAO.deleteDoc(map);
			}
			
			// 정상적으로 저장 후 이관여부 SET
			if (intCnt > 0) {
				paperMgmtDAO.updateMig(map);
			}
			
			
		}
		
		return strRefSeq;
	}
	

	/**
	 * 첨부파일 존재여부를 조회한다
	 * <pre>
	 * </pre>
	 * 
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public int selectMigFile(DataSetMap list) throws Exception {
		int selRowCnt = 0;

		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			
			String sourceFile = propertiesService.getString("global.filerepository.path") + "/fm/fms/org" + "/" + rowData.get("ePath") + "/" + rowData.get("eFile");
			//String sourceFile = "/app/build/app_repository/ContractScan/org" + "/" +  rowData.get("ePath") + "/" + rowData.get("eFile");
		
			File objFile = new File(StringUtil.replaceRelativePath(sourceFile));

	        if(objFile.exists()) selRowCnt = 1;
	        else selRowCnt = 0;

			// DEBUG --- 1
			logger.debug(" ** 원본파일 여부 CHECK");
			logger.debug(" - sourceFile => " + sourceFile);
			logger.debug(" - selRowCnt => " + selRowCnt);
		
		
		}
		
		return selRowCnt;
	}
	
	
	
	
    /**
     * XPLATFORM DataSetMap의 첨부파일을 rowType에 따라 Insert/Update/Delete 처리한다.
     * <pre>
     * - 파일은 파일저장소에 저장된다.
     * - 파일 저장소는 global.filerepository.path가 된다.
     * </pre>
     * 
     * @parma listFile 첨부파일 Map List
     * @param relPath 파일이 저장될 상대패스
     * @param encYn 파일암호화여부
     * @return String 새로 채번된 참조일련번호 ("" 이면 변경되지 않음을 의미) 
     * @throws Exception
     */
	public String saveFile(DataSetMap listFile, String relPath, boolean encYn) throws Exception {
		return saveFile (listFile, relPath, encYn, false, false);
	}

    /**
     * XPLATFORM DataSetMap의 첨부파일을 rowType에 따라 Insert/Update/Delete 처리한다.
     * <pre>
     * - 파일은 파일저장소에 저장된다.
     * - 파일 저장소는 webRepoYn가 true이면 global.imagerepository.path, false이면 global.filerepository.path가 된다. 
     * </pre>
     * 
     * @parma listFile 첨부파일 Map List
     * @param relPath 파일이 저장될 상대패스
     * @param encYn 파일암호화여부
     * @param webRepoYn 파일저장소를 webapp 아래로 할지 여부(true이면 global.imagerepository.path 아래로 저장)
     * @return String 새로 채번된 참조일련번호 ("" 이면 변경되지 않음을 의미) 
     * @throws Exception
     */
	public String saveFile(DataSetMap listFile, String relPath, boolean encYn, boolean webRepoYn) throws Exception {
		return saveFile (listFile, relPath, encYn, webRepoYn, false);
	}	
	
    /**
     * XPLATFORM DataSetMap의 첨부파일을 rowType에 따라 Insert/Update/Delete 처리한다.
     * <pre>
     * - 파일은 파일저장소에 저장된다.
     * - 파일 저장소는 webRepoYn가 true이면 global.imagerepository.path, false이면 global.filerepository.path가 된다.
     * - useOrgnlNmYn가 true이면 원본 파일명을 유지 
     * </pre>
     * @parma listFile 첨부파일 Map List
     * @param relPath 파일이 저장될 상대패스
     * @param encYn 파일암호화여부
     * @param webRepoYn 파일저장소를 webapp 아래로 할지 여부(true이면 global.imagerepository.path 아래로 저장)
     * @param useOrgnlNmYn 파일저장 시 원본 파일명을 유지할지 여부 (보안에 문제가 없는 파일인 경우만 원본명 유지 가능)
     * @return String 새로 채번된 참조일련번호 ("" 이면 변경되지 않음을 의미) 
     * @throws Exception
     */
	public String saveFile(DataSetMap listFile, String relPath, boolean encYn, boolean webRepoYn, boolean useOrgnlNmYn) throws Exception {

		String strRefSeq = ""; //첨부일련번호
		String relPath2 = "";
		
		//첨부일련번호를 얻는다.
		for (int i = 0; i < listFile.size(); i++) {
			Map<String, Object> map = listFile.get(i);
			int rowType = ((Integer) map.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			if (rowType != DataSet.ROW_TYPE_INSERTED) { //ROW_TYPE_UPDATED || rowType == DataSet.ROW_TYPE_DELETED){
				strRefSeq =  map.get("refSeq").toString(); //Long.parseLong(map.get("refSeq").toString());
				break;
			}
		}
		//첨부일련번호를 새로 채번하는 경우 처리
		if (strRefSeq.equals(""))
			strRefSeq = idGenSequenceAtchFile.getNextStringId();
		
		int intCnt=0;	//파일 처리 건수
		
		//먼저 첨부파일 처리
		for (int i = 0; i < listFile.size(); i++) {
			Map<String, Object> map = listFile.get(i);
			
			int rowType = ((Integer) map.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			if ( rowType == DataSet.ROW_TYPE_INSERTED ){
				//첨부일련번호 설정
				map.put("refSeq", strRefSeq);
				
				//저장시 원본파일명 유지 여부에 따라 처리
				if (!useOrgnlNmYn) {
					//저장파일명 설정 - UUID 적용 및 시간표시
					if (propertiesService.getBoolean("global.fileupload.appendTime"))
						map.put("saveFileNm", idGenUUIdService.getNextStringHostId() + "-" + DateUtil.getYyyymmddhhmmss());
					else
						map.put("saveFileNm", idGenUUIdService.getNextStringHostId());
				}else{
					//map.put("saveFileNm", DateUtil.getYyyymmddhhmmss() + "-" + map.get("orgnlFileNm"));
					map.put("saveFileNm", map.get("orgnlFileNm"));
				}
				//저장상대패스 설정
				//map.put("relPath", relPath);
				relPath2 = relPath + "/fms/scan/" + map.get("upPath");
				map.put("relPath", relPath2);
				
				//파일암호화 여부
				map.put("encYn", encYn ? "Y" : "N");
				
				//DAO 호출
				intCnt += attachFileDAO.insert(map);				
				
				//파일저장소로 복사 : Temporary 폴더
				// propertiesService.getString("global.filerepository.path") = "C:/HWFS_DEV/workspace/hwfs/data/filerepository"
				//String sourceFile = propertiesService.getString("global.fileupload.path") + "/" + map.get("fileUploadNm");
				String sourceFile = propertiesService.getString("global.filerepository.path") + "/fm/fms/org" + "/" + map.get("upPath") + "/" + map.get("orgnlFileNm");
				//String sourceFile = "/app/build/app_repository/ContractScan/org" + "/" + map.get("upPath") + "/" + map.get("orgnlFileNm");

				// DEBUG --- 1
				logger.debug(" ** =================================");
				// DEBUG --- 1
				logger.debug(" ** 파일이관 소스파일");
				logger.debug(" - sourceFile => " + sourceFile);
				
				String targetFile;
				if (webRepoYn)
					targetFile = propertiesService.getString("global.imagerepository.path") + relPath2 + "/" + map.get("saveFileNm"); 
				else
					// C:/HWFS_DEV/workspace/hwfs/data/filerepository
					targetFile = propertiesService.getString("global.filerepository.path") + relPath2 + "/" + map.get("saveFileNm");

				// DEBUG --- 2
				logger.debug(" - targetFile => " + targetFile);
				
				
				//-파일암호화 처리
				if (encYn) {
					String encFile = sourceFile + "_enc";
					cryptoService.encryptFile(sourceFile, encFile);
					sourceFile = encFile;
				}
				
				boolean isCopied = FileUtil.copyFile (sourceFile, targetFile);
				if (!isCopied)
					throw super.processException("fail.uploadfile.not.found");
				
			}else if (rowType == DataSet.ROW_TYPE_UPDATED){
				intCnt += attachFileDAO.update(map);
			}else if (rowType == DataSet.ROW_TYPE_DELETED){
				intCnt += attachFileDAO.delete(map);
				//파일저장소 파일 삭제
				String targetFile;
				if (webRepoYn)
					targetFile = propertiesService.getString("global.imagerepository.path") + map.get("relPath") + "/" + map.get("saveFileNm");
				else
					targetFile = propertiesService.getString("global.filerepository.path") + map.get("relPath") + "/" + map.get("saveFileNm");
				FileUtil.deleteFile(targetFile);
			}
		}
		
		//새로 채번된 참조일련번호 (-1 이면 변경되지 않음을 의미)
		if (intCnt == 0)
			return "";
		else			
			return strRefSeq;
	}
	
	
	
	
	
	
	
}
