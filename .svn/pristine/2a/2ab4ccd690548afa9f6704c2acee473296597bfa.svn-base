package com.hwfs.sc.cmn.service;

import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.crypto.aria.ARIACryptoServiceImpl;
import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.idgen.SequenceIdGenService;
import com.hwfs.cmn.idgen.UUIdGenService;
import com.hwfs.cmn.util.DateUtil;
import com.hwfs.sc.cmn.dao.AttachFileDAO;
import com.hwfs.sc.cmn.dto.AttachFileDTO;
import com.hwfs.sc.cmn.util.FileUtil;
import com.tobesoft.xplatform.data.DataSet;

/**
* 첨부파일을 관리하는 공통 Service Implementation
* <pre>
* - 첨부파일을 공통 테이블에 저장하고 디렉토리에 파일형태 또는 BLOB으로 저장한다. (현재 BLOB 미지원)
* - 파일 암호화를 선택적으로 처리할 수 있다.
* </pre>
* @ClassName AttachFileService.java
* @Description AttachFileService Class 
* @Modification-Information
* <pre>
*    수정일       수정자              수정내용
*  ----------   ----------   -------------------------------
*  2014.12. 08.   kksoo        최초생성
* </pre>
* @author FC종합전산구축 : AA kksoo
* @since 2014.12.08.
* @version 1.0
* @see 
* <pre>
*  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
* </pre>
*/
@Service("/sc/cmn/attachFileService")
public class AttachFileServiceImpl extends DefaultServiceImpl implements AttachFileService {

	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

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
	public String save(DataSetMap listFile, String relPath, boolean encYn) throws Exception {
		return save (listFile, relPath, encYn, false, false);
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
	public String save(DataSetMap listFile, String relPath, boolean encYn, boolean webRepoYn) throws Exception {
		return save (listFile, relPath, encYn, webRepoYn, false);
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
	public String save(DataSetMap listFile, String relPath, boolean encYn, boolean webRepoYn, boolean useOrgnlNmYn) throws Exception {

		String strRefSeq = ""; //첨부일련번호
		
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
					map.put("saveFileNm", DateUtil.getYyyymmddhhmmss() + "-" + map.get("orgnlFileNm"));
				}
				//저장상대패스 설정
				map.put("relPath", relPath);
				
				//파일암호화 여부
				map.put("encYn", encYn ? "Y" : "N");
				
				//DAO 호출
				intCnt += attachFileDAO.insert(map);				
				
				//파일저장소로 복사
				String sourceFile = propertiesService.getString("global.fileupload.path") + "/" + map.get("fileUploadNm");
				String targetFile;
				if (webRepoYn)
					targetFile = propertiesService.getString("global.imagerepository.path") + relPath + "/" + map.get("saveFileNm"); 
				else
					targetFile = propertiesService.getString("global.filerepository.path") + relPath + "/" + map.get("saveFileNm");
				
				//-파일암호화 처리
				if (encYn) {
					String encFile = sourceFile + "_enc";
					cryptoService.encryptFile(sourceFile, encFile);
					sourceFile = encFile;
				}
				
				logger.debug("sourceFile="+sourceFile);
				logger.debug("targetFile="+targetFile);
				
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

	/**
	 * 첨부파일 정보를 조회한다.
	 * 
	 * @param strRefSeq
	 *            - 첨부파일 참조일련번호
	 * @param lngAtchSeq
	 *            - 첨부일련번호
	 * @return 첨부파일정보 VO
	 * @exception Exception
	 */
	public AttachFileDTO selectFileInfo(String strRefSeq, long lngAtchSeq) throws Exception {
		return attachFileDAO.selectFileInfo(strRefSeq, lngAtchSeq);
	}

	/**
	 * 첨부파일 목록을 조회한다.
	 * <pre>
	 * 첨부파일 참조일련번호에 관련된 모든 첨부파일 정보를 조회한다. 
	 * </pre>
	 *
	 * @param strRefSeq 첨부파일 참조일련번호
	 * @return 첨부파일 목록 List<Map>
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public List<Map> selectList(String strRefSeq) throws Exception {
		List<Map> list;
		if (!strRefSeq.equals (""))
			list = attachFileDAO.selectList(strRefSeq);
		else
			list = new ArrayList<Map>();
		
		return list;
	}

	/**
	 * 첨부파일을 삭제한다.
	 * <pre>
	 * - 첨부파일 테이블과 파일저장소의 파일을 함께 삭제한다.
     * - 파일 저장소는 global.filerepository.path가 된다.
	 * </pre>
	 *
	 * @param strRefSeq 첨부파일 참조일련번호
	 * @return 처리건수
	 * @throws Exception
	 */
	public int delete (String strRefSeq) throws Exception {
		return delete (strRefSeq, false);
	}

	/**
	 * 첨부파일을 삭제한다.
	 * <pre>
	 * - 첨부파일 테이블과 파일저장소의 파일을 함께 삭제한다.
     * - 파일 저장소는 webRepoYn가 true이면 global.imagerepository.path, false이면 global.filerepository.path가 된다. 
	 * </pre>
	 * 
	 * @param lngSeqRel 첨부파일 참조일련번호
     * @param webRepoYn 파일저장소가 webapp 아래인지 여부(true이면 global.imagerepository.path 아래가 된다.)
	 * @return 처리건수
	 * @throws Exception
	 */
	public int delete (String strRefSeq, boolean webRepoYn) throws Exception {
		if (strRefSeq.equals("")) return 0;
		
		Map<String, Object> map = new HashMap<String, Object>();
		//첨부일련번호 설정
		map.put("refSeq", strRefSeq);
		
		//삭제할 파일정보를 얻는다.
		List<Map> list = attachFileDAO.selectList(strRefSeq);

		int intCnt = 0;
		if (list.size() == 0) return intCnt;
		
		//DB에서 첨부파일을 삭제한다.
		intCnt =  attachFileDAO.delete(map);
		
		//파일저장소에서 첨부파일을 삭제한다.
		deleteRepositoryFile (list, webRepoYn);
		
		return intCnt;
	}

	/**
	 * 파일저장소에서 첨부파일을 삭제한다.
	 *
	 * @param list 첨부파일정보
     * @param webRepoYn 파일저장소가 webapp 아래인지 여부(true이면 global.imagerepository.path 아래가 된다.)
	 * @throws Exception
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	private void deleteRepositoryFile (List<Map> list, boolean webRepoYn) throws Exception {
		//파일저장소에서 첨부파일을 삭제한다.
		for (int i=0; i<list.size(); i++) {
			Map<String, Object> map = list.get(i);
			String targetFile;
			if (webRepoYn)
				targetFile = propertiesService.getString("global.imagerepository.path") + map.get("pathRel") + "/" + map.get("nmSavefile");
			else
				targetFile = propertiesService.getString("global.filerepository.path") + map.get("pathRel") + "/" + map.get("nmSavefile");
			FileUtil.deleteFile(targetFile);
		}		
	}

}
