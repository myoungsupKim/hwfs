package com.hwfs.fm.fmc.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.io.File;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.terracotta.modules.ehcache.async.exceptions.ProcessingException;

import com.hwfs.cmn.crypto.aria.ARIACryptoServiceImpl;
import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.cmn.idgen.SequenceIdGenService;
import com.hwfs.cmn.idgen.UUIdGenService;
import com.hwfs.cmn.util.DateUtil;
import com.hwfs.fm.fmc.dao.ClaimRegDAO;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.sc.cmn.dao.AttachFileDAO;
import com.hwfs.sc.cmn.service.AttachFileService;
import com.hwfs.sc.cmn.util.FileUtil;
import com.sz.core.ServiceManagerFactory;
import com.sz.service.ui.HttpFileManager;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 클레임요청하는 ClaimReg Service Implementation
 * 
 * @ClassName ClaimRegServiceImpl.java
 * @Description ClaimRegServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.06    최영준        최초생성
 *  2015.07.13	  손형민		인수인계
 *  2021.08.09    DEV02         [PJT]주문채널통합
 * </pre>
 * @author FC종합전산구축 : 통합영업 최영준
 * @since 2015.05.06
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fm/fmc/claimRegService")
public class ClaimRegServiceImpl extends DefaultServiceImpl implements ClaimRegService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	/** CryptoService */
    @Resource(name = "ariaCryptoService")
    protected ARIACryptoServiceImpl cryptoService;
	
	/** AttachFileDAO */
    @Resource(name="/sc/cmn/attachFileDAO")
    private AttachFileDAO attachFileDAO;
    
    /** UUIdGenService */
    @Resource(name = "idGenUUIdService")
    protected UUIdGenService idGenUUIdService;
    
    /** File Attach DB Sequence idGnrService */
	@Resource(name="idGenSequenceAtchFile") 
	private SequenceIdGenService idGenSequenceAtchFile;
	
	/** AttachFile Service Bean 생성 */
	@Resource(name = "/sc/cmn/attachFileService")
	private AttachFileService attachFileService;
	
	/** ClaimRegDAO Bean 생성 */
	@Resource(name = "/fm/fmc/claimRegDAO")
	private ClaimRegDAO claimRegDAO;
	
	/**
	 * 업장별 창고리스트 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectSubinv(Map<String, Object> mapParam) throws Exception {
		return claimRegDAO.selectSubinv(mapParam);
	}
	

	/**
	 * 클레임요청 목록을 조회한다.
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
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return claimRegDAO.selectList(mapParam);
	}
	
	/**
	 * 클레임요청 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 *   [PJT]주문채널통합
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectBrandList(Map<String, Object> mapParam) throws Exception {
		return claimRegDAO.selectBrandList(mapParam);
	}
	
	/**
	 * 공통코드 목록을 조회한다.
	 *
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	public RecordSet commonList(Map <String, Object> parm) throws Exception {
		return claimRegDAO.commonList(parm);
	}
	
	/**
	 * PC사진 목록을 조회한다.
	 *
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	public RecordSet selectPC(Map<String, Object> inVar) throws Exception{
		return claimRegDAO.selectPC(inVar);
	}
	
	/**
	 * Mobile사진 목록을 조회한다.
	 *
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	public RecordSet selectMobile(Map<String, Object> inVar) throws Exception{
		return claimRegDAO.selectMobile(inVar);
	}

	/**
	 * 클레임요청 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
		int updRowCnt = 0;
		int delRowCnt = 0;
		boolean update = true;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);

			logger.debug("rowData : " + rowData);
			if("1".equals(rowData.get("checked").toString())){
				if("01".equals(rowData.get("prcsStatus").toString()) && "I".equals(rowData.get("saveFlag").toString())){//요청
					
					int claimYn = claimRegDAO.claiminsertYn(rowData);
					if(claimYn > 0){
						throw new BizException("이미 등록된 주문건 입니다. 재조회 후 요청해 주세요.");
					}
					String flag = claimRegDAO.ticketFlag(rowData);
					logger.debug("flag : " + flag);

					if(!"TRUE".equals(flag)){
						throw new BizException("매출 또는 선수금 등록 건이 있어 식권 전량폐기가 불가능 합니다.");
					}
					/**
					 * 업체주의요청 일경우 바로 처리완료(09)  요청자:전은정 2015-11-02
					 */
					if("C0206".equals(rowData.get("reqKind")) || "C0595".equals(rowData.get("ctClaimKind")) ||"C05039".equals(rowData.get("ctClaimKind")) ){
						//rowData.put("prcsStatus", "09");
					}
					
					if ( "Y".equals(rowData.get("wmCancelYn")) && "C05002".equals(rowData.get("ctClaimKind"))) {
						rowData.put("prcsStatus", "09");	// 센터 재고부족으로 발주취소된 경우
					}
					insRowCnt += claimRegDAO.insert(rowData);
				}
				else if("08".equals(rowData.get("prcsStatus").toString())  && "C".equals(rowData.get("saveFlag").toString())){//취소
					String procStatus = claimRegDAO.claimStatus(rowData);//상태값 재 조회
					if(!"01".equals(procStatus)){
						update = false;//요청이 아닐경우.
					}
					
					if(update){
						updRowCnt += claimRegDAO.claimHistorySave(rowData);//히스토리 저장.
						
						delRowCnt += claimRegDAO.delete(rowData);//클레임 삭제.
					}else{
						throw new BizException("클레임 요청건만 취소 할수 있습니다.");
					}
				}
			}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
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
	public String saveAttachFile(DataSetMap list, DataSetMap listFile) throws Exception {
		String strRefSeq = "";	//첨부참조일련번호

		//첨부파일 처리 : 업무별 저장소의 상대패스를 파라미터로 전달해야 한다.
		strRefSeq = attachFileService.save(listFile, propertiesService.getString("fm.file.path"), false, true);

		int intCnt=0;
		//데이터 저장 처리
		for (int i = 0; i < list.size(); i++) {
			Map<String, Object> map = list.get(i);
			//첨부참조일련번호 설정
			if (!strRefSeq.equals(""))
				map.put("refSeq", strRefSeq);

			int rowType = ((Integer) map.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			if ( rowType == DataSet.ROW_TYPE_INSERTED ){
				intCnt += claimRegDAO.insertPC(map);
			}else if (rowType == DataSet.ROW_TYPE_UPDATED){
				intCnt += claimRegDAO.updatePC(map);
			}else if (rowType == DataSet.ROW_TYPE_DELETED){
				intCnt += claimRegDAO.deletePC(map);
			}else if (!strRefSeq.equals("")) {
				//(주의)나머지 rowType인 경우 첨부참조일련번호가 새로 채번된 경우 Update하도록 함
				intCnt += claimRegDAO.updatePC(map);
			}
		}

		return strRefSeq;
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
     * @param seq 파일이 저장될 첨부일련번호 ID
     * @return String 새로 채번된 참조일련번호 ("" 이면 변경되지 않음을 의미) 
     * @throws Exception
     */
	public String save(DataSetMap listFile, String relPath, boolean encYn, boolean webRepoYn, boolean useOrgnlNmYn, String seq) throws Exception {

		//String strRefSeq = ""; //첨부일련번호
		String strRefSeq = seq; //첨부일련번호
		/*
		//첨부일련번호를 얻는다.
		for (int i = 0; i < listFile.size(); i++) {
			Map<String, Object> map = listFile.get(i);
			int rowType = ((Integer) map.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			if (rowType != DataSet.ROW_TYPE_INSERTED) { //ROW_TYPE_UPDATED || rowType == DataSet.ROW_TYPE_DELETED){
				strRefSeq =  map.get("refSeq").toString(); //Long.parseLong(map.get("refSeq").toString());
				break;
			}
		}
		*/
		//첨부일련번호를 새로 채번하는 경우 처리
		if (strRefSeq.equals("") || strRefSeq.equals("undefined"))
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
				String path = (String) map.get("relPath");
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
				
				boolean isCopied = false;
                if(!"".equals(LimsUtil.checkNull(path))) {
                    //HttpFileManager file = (HttpFileManager) ServiceManagerFactory.getServiceObject("HttpFileManagerService");
                    String dirFrom       = propertiesService.getString("global.imagerepository.path") + "/" + propertiesService.getString("ms.file.path");
                    String preView       = LimsUtil.checkNull(path) +"/"+LimsUtil.checkNull(map.get("orgnlFileNm").toString());
                    File   preFile       = new File(dirFrom + preView);
                    
                    // 파일 이동처리
                    FileUtils.copyFile(preFile, new File(targetFile));
                    if(preFile.isFile()) {
                        isCopied = true;   
                    }
                } else {
                    // 파일 이동처리
                    isCopied = FileUtil.copyFile (sourceFile, targetFile);
                }
				
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
	 * 모바일에서 첫번째로 저장시 클레임 사진정보 저장
	 *
	 * @param list, FileId
	 * @return 처리건수
	 * @throws Exception
	*/
	public int saveFileId(DataSetMap list, String strRefSeq) throws Exception{
		Map<String, Object> map = list.get(0);
		map.put("refSeq", strRefSeq);
		return claimRegDAO.insertPC(map);
	}
	
	
	/**
	 * 자재별 재고량 확인.
	 *
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	public Map<String, Object> ItemQty(DataSetMap list) throws Exception{
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			if("1".equals(rowData.get("checked").toString()) && rowType == DataSet.ROW_TYPE_UPDATED){
				//Update 처리
				RecordSet row = claimRegDAO.itemQty(rowData);
				Map<String, Object> rowCLM = row.get(0);
				if("N".equals(rowCLM.get("claimQty"))){
					return rowCLM;
				}
			}
		}
		return null;
	}
	
	/**
	 * 콤마 값을 IN 처리에 맞게 변경.
	 *
	 * @param String
	 * @return String
	 * @throws Exception
	*/
	public String inCode(String schCode) throws Exception {
		if(schCode.indexOf(',') != -1)
			return "'"+schCode.replaceAll(",", "','")+"'";
		else
			return "'"+schCode+"'";
	}
}
