package com.hwfs.fs.fsb.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fs.fsb.dao.UpjangPackMgntDAO;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.cmn.service.AddrSearchService;
import com.hwfs.sc.cmn.service.AttachFileService;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 업장관리하는 UpjangPackMgnt Service Implementation
 * 
 * @ClassName UpjangPackMgntServiceImpl.java
 * @Description UpjangPackMgntServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.06    최문규        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최문규
 * @since 2015.05.06
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fs/fsb/upjangPackMgntService")
public class UpjangPackMgntServiceImpl extends DefaultServiceImpl implements UpjangPackMgntService {
	
	//주소를 처리하기 위한 공통 Service
	@Resource(name = "/sc/cmn/addrSearchService")
	private AddrSearchService addressService;
	
	/** AttachFile Service Bean 생성 */
	@Resource(name = "/sc/cmn/attachFileService")
	private AttachFileService attachFileService;
	
	/** UpjangPackMgntDAO Bean 생성 */
	@Resource(name = "/fs/fsb/upjangPackMgntDAO")
	private UpjangPackMgntDAO upjangPackMgntDAO;
	
	
	/**
	 * Combo 코드목록을 조회한다.
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
	public Map<String, RecordSet> selectCode(Map<String, Object> mapParam) throws Exception {
				
		RecordSet rs1 = upjangPackMgntDAO.selectJobCode(mapParam);
		RecordSet rs2 = upjangPackMgntDAO.selectSubJobCode(mapParam);
		RecordSet rs3 = upjangPackMgntDAO.selectLocCode(mapParam);
		RecordSet rs4 = upjangPackMgntDAO.selectSubLocCode(mapParam);
		RecordSet rs5 = upjangPackMgntDAO.selectPermissionType(mapParam);
		
		Map<String, RecordSet> rsMap = new HashMap<String, RecordSet>();
		rsMap.put("job", rs1);
		rsMap.put("subJob", rs2);
		rsMap.put("loc", rs3);
		rsMap.put("subLoc", rs4);
		rsMap.put("permission", rs5);
		return rsMap;
	}
	
	/**
	 * 식단가현황 메뉴구분코드 조회한다.
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
	public RecordSet selectFilterGubunCd2(Map<String, Object> mapParam) throws Exception {
		return upjangPackMgntDAO.selectFilterGubunCd2(mapParam);
	}
	
	/**
	 * 회계정보(Tab1),운영현황(Tab2),계약정보(Tab3)를 조회한다.
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
	public Map<String, RecordSet> selectAccountingInfo(Map<String, Object> mapParam) throws Exception {
		
		RecordSet rs1 = upjangPackMgntDAO.selectBankList(mapParam);
		RecordSet rs2 = upjangPackMgntDAO.selectAccountingInfo(mapParam);
		RecordSet rs3 = upjangPackMgntDAO.selectMemberInfoList(mapParam);
		RecordSet rs4 = upjangPackMgntDAO.selectJikchakHistory(mapParam);
		RecordSet rs5 = upjangPackMgntDAO.selectMemberCount(mapParam);
		RecordSet rs6 = upjangPackMgntDAO.selectMpriceInfo(mapParam);
		RecordSet rs7 = upjangPackMgntDAO.selectMemberCount2(mapParam);
		//상세 배송주소 추가 20190507 김호석(요청자:이혜은)
		RecordSet rs8 = upjangPackMgntDAO.selectDetailAddr(mapParam);
		
		Map<String, RecordSet> rsMap = new HashMap<String, RecordSet>();
		rsMap.put("bank", rs1);
		rsMap.put("account", rs2);
		rsMap.put("memberInfo", rs3);
		rsMap.put("jikchakHistory", rs4);
		rsMap.put("memberCount", rs5);
		rsMap.put("mpriceInfo", rs6);
		rsMap.put("memberCount2", rs7);
		rsMap.put("detailAddr", rs8);
		return rsMap;
	}

	/**
	 * 업장관리 상세 전체(Tab1~Tab8) 목록을 조회한다.
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
	public Map<String, RecordSet> selectUpjangPackMgnt(Map<String, Object> mapParam) throws Exception {
		
		RecordSet rs1 = upjangPackMgntDAO.selectDeptHistory(mapParam);
		RecordSet rs2 = upjangPackMgntDAO.selectRemainmealdtl(mapParam);
		RecordSet rs3 = upjangPackMgntDAO.selectUtensilList(mapParam);
		RecordSet rs4 = upjangPackMgntDAO.selectCustList(mapParam);
		RecordSet rs5 = upjangPackMgntDAO.selectDocList(mapParam);
		RecordSet rs6 = upjangPackMgntDAO.selectMemberHistory(mapParam);
		RecordSet rs7 = upjangPackMgntDAO.selectMpriceHistory(mapParam);
		RecordSet rs8 = upjangPackMgntDAO.selectRespMealList(mapParam);
		RecordSet rs9 = upjangPackMgntDAO.selectGuarantyAmtInfo(mapParam);
		Map<String, RecordSet> rsMap = new HashMap<String, RecordSet>();
		
		rsMap.put("deptHistory", rs1);
		rsMap.put("remainmealdtl", rs2);
		rsMap.put("utensil", rs3);
		rsMap.put("cust", rs4);
		rsMap.put("doc", rs5);		
		rsMap.put("memberHistory", rs6);
		rsMap.put("mpriceHistory", rs7);
		rsMap.put("respMeal", rs8);
		rsMap.put("guarantyAmt", rs9);
		
		return rsMap;
	}
	
	/**
	 * 계약정보(TAB3) 총투자실적, 보증금잔액, 미상각잔액 조회한다.
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
	public RecordSet selectInvAmt(Map<String, Object> mapParam) throws Exception {
		return upjangPackMgntDAO.selectInvAmt(mapParam);
	}
		
	/**
	 * 인원현황(TAB5) 발령History 목록을 조회한다.
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
	public RecordSet selectMemberHistory(Map<String, Object> mapParam) throws Exception {
		return upjangPackMgntDAO.selectMemberHistory(mapParam);
	}
	
	/**
	 * 예산현황(TAB7) 목록을 조회한다.
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
	public RecordSet selectBudgetInfo(Map<String, Object> mapParam) throws Exception {
		return upjangPackMgntDAO.selectBudgetInfo(mapParam);
	}
	
	/**
	 * 임대/보증금 현황(TAB8) 목록을 조회한다.
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
	public RecordSet selectGuarantyAmtInfo(Map<String, Object> mapParam) throws Exception {
		return upjangPackMgntDAO.selectGuarantyAmtInfo(mapParam);
	}
	
	/**
	 * 기기보유현황 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int saveUtensil(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insRowCnt += upjangPackMgntDAO.insertUtensil(rowData);
				upjangPackMgntDAO.insertUtensilHistory(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += upjangPackMgntDAO.updateUtensil(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += upjangPackMgntDAO.deleteUtensil(rowData);
			}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
	
	/**
	 * 고객사현황 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int saveCustInfo(DataSetMap listSearch, DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			String authLevel = listSearch.get(0).get("authLevel").toString();
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insRowCnt += upjangPackMgntDAO.insertCustInfo(rowData);
				upjangPackMgntDAO.insertCustInfoHistory(rowData);
				
				rowData.put("name", rowData.get("drname1"));	// 대표자명
				rowData.put("homeAddr", rowData.get("addr"));	// 주소
				rowData.put("homeAddrEnc", rowData.get("addr"));	// 주소 암호화
				rowData.put("comTel", rowData.get("telNoEnc"));
				rowData.put("comTelEnc", rowData.get("telNoEnc"));	// 전화번호
				
				upjangPackMgntDAO.insertCustChgInfo(rowData);
				upjangPackMgntDAO.insertCustChgInfoHistory(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				
				rowData.put("authLevel", authLevel);
				updRowCnt += upjangPackMgntDAO.updateCustInfo(rowData);
				
				rowData.put("name", rowData.get("drname1"));	// 대표자명
				rowData.put("homeAddr", rowData.get("addr"));	// 주소
				rowData.put("homeAddrEnc", rowData.get("addr"));	// 주소 암호화
				rowData.put("comTel", rowData.get("telNoEnc"));
				rowData.put("comTelEnc", rowData.get("telNoEnc"));	// 전화번호
				upjangPackMgntDAO.updateCustChgInfo(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += upjangPackMgntDAO.deleteCustInfo(rowData);				
			}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
	
	/**
	 * 식단가현황 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int saveMpriceInfo(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
				
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insRowCnt += upjangPackMgntDAO.insertMpriceInfo(rowData);
				upjangPackMgntDAO.insertMpriceHistory(rowData);		// History 누적
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += upjangPackMgntDAO.updateMpriceInfo(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += upjangPackMgntDAO.deleteMpriceInfo(rowData);
			}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
	
	/**
	 * 업장관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public String saveAccountingInfo(Map<String, DataSetMap> param, LoginDTO loginDTO) throws Exception {
		
		DataSetMap listSearch 	  = param.get("ds_search");
		DataSetMap list 		  = param.get("ds_accountingInfo");		// master 정보
		DataSetMap listDtl  	  = param.get("ds_remainmealdtl");		// 잔반관리
		DataSetMap listMeal 	  = param.get("ds_respMealList");		// 대표식단가,식수
		DataSetMap listUtensil    = param.get("ds_utensil");			// 기기보유현황
		DataSetMap listCustMgnt   = param.get("ds_custMgnt");			// 고객사현황
		DataSetMap listMpriceInfo = param.get("ds_mpriceInfo");			// 식단가현황
		DataSetMap listDetailAddr = param.get("ds_detailAddr");			    // 상세 배송지주소
		DataSetMap listFile 	  = (DataSetMap) param.get("ds_file");	// 이미지 첨부파일 정보
		
		Map<String, Object> inParam = new HashMap<String, Object>();
		
		String strRefSeq = "";	//첨부참조일련번호
		//첨부파일 처리 : 업무별 저장소의 상대패스를 파라미터로 전달해야 한다.
		strRefSeq = attachFileService.save(listFile, propertiesService.getString("fs.file.path"), false, true);
		

		// 배송지주소 저장
		for (int i = 0 ; i < listDetailAddr.size() ; i++) {
			Map<String, Object> rowData = listDetailAddr.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Update 처리
			if (rowType == DataSet.ROW_TYPE_UPDATED) { 
				upjangPackMgntDAO.updateDetailAddr(rowData);
			}

		}
		
		for (int i = 0 ; i < list.size() ; i++) {
			
			Map<String, Object> rowData = list.get(i);
			
			//주소 처리
			Map<String, Object> rtn = addressService.setAddress(rowData, "addrInfo", loginDTO.getSabun());
			//주소 처리
			Map<String, Object> rtn2 = addressService.setAddress(rowData, "deliveryAddrInfo", loginDTO.getSabun());
			
			//첨부참조일련번호 설정
			if (!strRefSeq.equals(""))
				rowData.put("imgPath", strRefSeq);
			
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			//Update 처리
			if (rowType == DataSet.ROW_TYPE_UPDATED) {
				
				// 업장 기준 정보 update
				upjangPackMgntDAO.updateAccountingInfo(rowData);
				
				// 회계 개점일자, 회계 폐점일자 update (PI의 잘못된 요청이므로, 주석처리함.)
		//		upjangPackMgntDAO.updateStupjang(rowData);
				
				// 수정 이력을 SCO_UPJANG_MST_HIS 에 이력등록 한다.
				upjangPackMgntDAO.insertUpjangCnangeHistory(rowData);
				
				// 잔반관리 master 재등록하기 위해 삭제한다.
				upjangPackMgntDAO.deleteRemainmeal(rowData);
				// 잔반관리 master(을)를 등록한다.
				upjangPackMgntDAO.insertRemainmeal(rowData);
				// 잔반관리 master 이력정보(을)를 등록한다.
				upjangPackMgntDAO.insertRemainmealHistory(rowData);
							
			//	  new SqlParameter("P_UPJANG",    Types.INTEGER),
			//    new SqlParameter("P_JOB_CD",    Types.VARCHAR),
			//    new SqlParameter("P_SUB_JOB_CD",Types.VARCHAR),
			//    new SqlParameter("P_CUSER",     Types.VARCHAR),
				
				// 레시피분류를 재등록하기 위해 삭제한다.
				upjangPackMgntDAO.deleteFsaRecipeLink(rowData);
				// 레시피분류를 등록
				inParam.put("P_UPJANG", Integer.parseInt(String.valueOf(rowData.get("upjang"))));
				inParam.put("P_JOB_CD", String.valueOf(rowData.get("jobCd")));
				inParam.put("P_SUB_JOB_CD", String.valueOf(rowData.get("subJobCd")));
				inParam.put("P_CUSER", loginDTO.getSabun());
				upjangPackMgntDAO.callFsaUpjangRecipeClassPro(inParam);
			}else if (!strRefSeq.equals("")) {
				//(주의)나머지 rowType인 경우 첨부참조일련번호가 새로 채번된 경우 Update하도록 함
				upjangPackMgntDAO.updateImgfile(rowData);
			}
			
			// 잔반관리 detail 재등록하기 위해 삭제한다.
			Map<String, Object> rowData2 = listDtl.get(0);
			upjangPackMgntDAO.deleteRemainmealDtl(rowData2);
			// 잔반관리 detail 처리
			for(int j=0; j<listDtl.size(); j++) {		
				Map<String, Object> rowDataDtl = listDtl.get(j);
				int rowTypeDtl = ((Integer)rowDataDtl.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
				if(rowTypeDtl != DataSet.ROW_TYPE_DELETED && "1".equals(String.valueOf(rowDataDtl.get("chk")))) {					
						// 잔반관리 detail(을)를 등록한다.
						upjangPackMgntDAO.insertRemainmealDtl(rowDataDtl);
						// 잔반관리 detail 이력정보(을)를 등록한다.
						upjangPackMgntDAO.insertRemainmealDtlHistory(rowDataDtl);
					
				}
			}
		}
		
		// 대표식단가, 대표식수 저장
		for (int i = 0 ; i < listMeal.size() ; i++) {
			Map<String, Object> rowData = listMeal.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {				
				upjangPackMgntDAO.insertRespMealList(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				upjangPackMgntDAO.updateRespMealList(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				upjangPackMgntDAO.deleteRespMealList(rowData);
			}
		}
		
		// 기기보유현황 저장
		for (int i = 0 ; i < listUtensil.size() ; i++) {
			Map<String, Object> rowData = listUtensil.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				upjangPackMgntDAO.insertUtensil(rowData);
				upjangPackMgntDAO.insertUtensilHistory(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				upjangPackMgntDAO.updateUtensil(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				upjangPackMgntDAO.deleteUtensil(rowData);
			}
		}
		
		// 고객사현황 저장
		for (int i = 0 ; i < listCustMgnt.size() ; i++) {
			Map<String, Object> rowData = listCustMgnt.get(i);
			String authLevel = listSearch.get(0).get("authLevel").toString();
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				upjangPackMgntDAO.insertCustInfo(rowData);
				upjangPackMgntDAO.insertCustInfoHistory(rowData);
				
				rowData.put("name", rowData.get("drname1"));	// 대표자명
				rowData.put("homeAddr", rowData.get("addr"));	// 주소
				rowData.put("homeAddrEnc", rowData.get("addr"));	// 주소 암호화
				rowData.put("comTel", rowData.get("telNoEnc"));
				rowData.put("comTelEnc", rowData.get("telNoEnc"));	// 전화번호
				
				upjangPackMgntDAO.insertCustChgInfo(rowData);
				upjangPackMgntDAO.insertCustChgInfoHistory(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				
				rowData.put("authLevel", authLevel);
				upjangPackMgntDAO.updateCustInfo(rowData);
				
				rowData.put("name", rowData.get("drname1"));	// 대표자명
				rowData.put("homeAddr", rowData.get("addr"));	// 주소
				rowData.put("homeAddrEnc", rowData.get("addr"));	// 주소 암호화
				rowData.put("comTel", rowData.get("telNoEnc"));
				rowData.put("comTelEnc", rowData.get("telNoEnc"));	// 전화번호
				upjangPackMgntDAO.updateCustChgInfo(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				upjangPackMgntDAO.deleteCustInfo(rowData);				
			}
		}
		
		// 식단가현황 저장
		for (int i = 0 ; i < listMpriceInfo.size() ; i++) {
			Map<String, Object> rowData = listMpriceInfo.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				upjangPackMgntDAO.insertMpriceInfo(rowData);
				upjangPackMgntDAO.insertMpriceHistory(rowData);		// History 누적
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				upjangPackMgntDAO.updateMpriceInfo(rowData);
				upjangPackMgntDAO.insertMpriceHistory(rowData);		// History 누적
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				upjangPackMgntDAO.deleteMpriceInfo(rowData);
			}
		}
				
		return strRefSeq;
	}
}
