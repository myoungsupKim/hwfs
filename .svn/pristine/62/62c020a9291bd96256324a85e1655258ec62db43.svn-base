package com.hwfs.fm.fmo.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.collections.MapUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.fm.fmo.dao.OrderRequestDAO;
import com.hwfs.fm.fmo.dao.OrderRequestUploadDAO;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.cmn.util.Const;
import com.hwfs.sc.cmn.util.NumberUtil;
import com.hwfs.sc.cmn.util.StringUtil;
import com.hwfs.sc.cmn.util.ValidationUtil;
import com.sz.business.BusinessRuntimeException;

 /**
 * 주문 엑셀업로드하는 OrderRequestUpload Service Implementation
 * 
 * @ClassName OrderRequestUploadServiceImpl.java
 * @Description OrderRequestUploadServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.10.13    손형민        최초생성
 *  2021.07.27      DEV02     [PJT]주문채널통합
 *  2021.10.14	 hye.jin94 휴먼푸드 발주생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 손형민
 * @since 2015.10.13
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fm/fmo/orderRequestUploadService")
public class OrderRequestUploadServiceImpl extends DefaultServiceImpl implements OrderRequestUploadService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** OrderRequestUploadDAO Bean 생성 */
	@Resource(name = "/fm/fmo/orderRequestUploadDAO")
	private OrderRequestUploadDAO orderRequestUploadDAO;
	
	/** OrderRequestDAO Bean 생성 */
	@Resource(name = "/fm/fmo/orderRequestDAO")
	private OrderRequestDAO orderRequestDAO;
	

	/**
	 * 주문 엑셀업로드 목록을 조회한다.
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
	public int selectList(DataSetMap list) throws Exception {
		Map<String, List> rsMap = new HashMap<String, List>();
		List<Map<String, Object>> listSet = new ArrayList();
		List<Map<String, Object>> errorSet = new ArrayList(); 
		List<Map> listMap = new ArrayList<Map>();
		/*	엑셀 업로드시 PR_NUM 을 생성한다.	*/
		Map<String, Object> row = list.get(0);
		String prNum = orderRequestUploadDAO.excelPrNum(row);
		int inCnt = 0;
		int[] inCnts = null;
		/*	엑셀 리스트를 TEMP 테이블에 INSERT	*/
		for (int i = 0; i < list.size(); i++) {
			Map<String, Object> rowData = list.get(i);
			rowData.put("prNum", prNum);
			listMap.add(rowData);
		}
		if(listMap.size() == 0){
			throw new BizException("오류가 발생하였습니다. 재업로드 해주세요.\n(업로드할 데이터가 없습니다.)");
		}else{
			inCnts = orderRequestUploadDAO.tempInsert(listMap);
		}
		
//		String apNum = orderRequestDAO.selectApNum(row);
		//rowData.put("approveNum", apNum);
		
		/*	엑셀 리스트와 INSERT 건수가 다르면 에러발생.	*/
		if(inCnts.length != list.size()){
			throw new BizException("오류가 발생하였습니다. 재업로드 해주세요.\n(저장한 데이터와 실데이터가 다름.)");
		}
		inCnt = orderRequestUploadDAO.tempUpdate(row);
		logger.debug("temp_update : " + inCnt);

		
		logger.debug("##########");
		logger.debug("##########");
		row.put("prNum", prNum);
		logger.debug("### prNum : " + prNum);
		List<Map> temp = orderRequestUploadDAO.select(row);
		logger.debug("tempsize : " + temp.size());
		logger.debug("##########");
		logger.debug("##########");
		for (int i = 0; i < temp.size(); i++) {
			Map<String, Object> rowData = temp.get(i);
			// 오류 검증용 CHECK 필드
			//System.out.println("############## :" + rowData);
			if("N".equals(rowData.get("error").toString())){
				listSet.add(rowData);
			}else{
				errorSet.add(rowData);
			}
		}
		//과거 데이터 삭제
		orderRequestUploadDAO.tempDel(row);
		
		rsMap.put("dsList", listSet);
		rsMap.put("dsListError", errorSet);
		
		return 0;
	}

	/**
	 * 주문 엑셀업로드 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 구매유형 : 식자재_식재영업(FS) : 07 자료 기준 
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public Map<String, List> saveList(DataSetMap list,LoginDTO loginDTO) throws Exception {
		Map<String, List> rsMap = new HashMap<String, List>();
		List<Map<String, Object>> listSet = new ArrayList();
		List<Map<String, Object>> errorSet = new ArrayList(); 
		List<Map> listMap = new ArrayList<Map>();
		logger.debug("loginDTO : " + loginDTO);
		/*	엑셀 업로드시 PR_NUM 을 생성한다.	*/
		Map<String, Object> row = list.get(0);
		String prNum = orderRequestUploadDAO.excelPrNum(row);
		logger.debug("prNum : " + prNum);
		int inCnt = 0;
		int[] inCnts = null;
		/*	엑셀 리스트를 TEMP 테이블에 INSERT	*/
		for (int i = 0; i < list.size(); i++) {
			Map<String, Object> rowData = list.get(i);
			rowData.put("prNum", prNum);
			listMap.add(rowData);
		}
		if(listMap.size() == 0){
			throw new BizException("오류가 발생하였습니다. 재업로드 해주세요.\n(업로드할 데이터가 없습니다.)");
		}else{
			inCnts = orderRequestUploadDAO.tempInsert(listMap);
		}
		
		String apNum = orderRequestDAO.selectApNum(row);
		row.put("approveNum", apNum);
		
		/*	엑셀 리스트와 INSERT 건수가 다르면 에러발생.	*/
		if(inCnts.length != list.size()){
			throw new BizException("오류가 발생하였습니다. 재업로드 해주세요.\n(저장한 데이터와 실데이터가 다름.)");
		}
		inCnt = orderRequestUploadDAO.tempUpdate(row);
		logger.debug("temp_update : " + inCnt);
		inCnt = orderRequestUploadDAO.insert(row);
		logger.debug("fms_so_pr_temp insert : " + inCnt);
		
		logger.debug("##########");
		logger.debug("##########");
		
		row.put("prNum", prNum);
		
		/** 
		 * 	여신 체크 :  2015-11-30, 여신체크 단위를 본사, 본사통합여신 기준으로 체크
		 * 																**/
		// 여신체크 변수
		String headCreditYn = "";
		DecimalFormat df = new DecimalFormat("#,##0");
		
		String rcUpjang = "";

		List<Map> groupUpjang = orderRequestUploadDAO.upjangGroup(row);
		
		logger.debug("groupUpjang.size() : " + groupUpjang.size());
		
		for (int i = 0; i < groupUpjang.size(); i++) {
			Map<String, Object> rowData = groupUpjang.get(i);
			logger.debug("groupUpjang : " + groupUpjang.size() + "		:  " + i );
			
			headCreditYn = rowData.get("headCreditYn").toString();
			
// [속도개선 Project 시작] 2017. 8. 21. 최범주 여신정보조회 함수 대체
//			//=============================================
//			// 여신기준일자 CHECK  : 2015-12-24
//			//=============================================
//			RecordSet rsDate;
//			// 기준일자 SET
//			if(("Y").equals(rowData.get("headCreditYn")))
//				rsDate = orderRequestUploadDAO.selectNeedDate(rowData);
//			else
//				rsDate = orderRequestUploadDAO.selectNeedDate2(rowData);
//
//			if (rsDate.size() > 0)
//			{
//				Map map = rsDate.get(0);
//				// DEBUG --- 2
//				logger.debug(" 기준일자 변경 후");
//				logger.debug(" - needDate => " + map.get("needDate").toString());
//				
//				rowData.put("needDate", map.get("needDate").toString());
//			}
//			//=============================================
//			
//			
//			Map<String, Object> creInfo = orderRequestUploadDAO.selectCreInfo(rowData);
			Map<String, Object> inParam = new HashMap<String, Object>();
			inParam.put("schUpjang", rowData.get("rcUpjang").toString());
			inParam.put("schNeedDate", rowData.get("needDate").toString());
			Map<String, Object> creInfo = orderRequestDAO.selectCreInfo(inParam).get(0);
			
			rcUpjang = rowData.get("rcUpjang").toString();
// [속도개선 Project   끝] 2017. 8. 21. 최범주
			// 본사통합여신 및 미통합 구분 체크
			// 여신체크여부(CREDIT_CONTROL_YN)에 대한 여부는 PASS, 여신관리 여부(필요 시 upjangGroup QUERY에 필드 추가 후 CHECK)
			if ("Y".equals(headCreditYn)) {
				logger.debug("=====본사통합여신=====");
				logger.debug(rowData.get("mainUpjang")+" : " + rowData.get("amt"));
				logger.debug(rowData.get("mainUpjang")+" : " + creInfo.get("creditAvailAmt"));
			} else {
				logger.debug("=====단일업장여신=====");
				logger.debug(rowData.get("rcUpjang")+" : " + rowData.get("amt"));
				logger.debug(rowData.get("rcUpjang")+" : " + creInfo.get("creditAvailAmt"));
			}
			if(Double.valueOf(rowData.get("amt").toString()) > Double.valueOf((creInfo.get("creditAvailAmt").toString()))){
				logger.debug("여신초과");
				// 여신초과 메시지
				String sMsg = "";
				sMsg = "(";
				sMsg = sMsg + "주문가능 : " + df.format(Double.valueOf(creInfo.get("creditAvailAmt").toString()));
				sMsg = sMsg + ", 판매금액 : " + df.format(Double.valueOf(rowData.get("amt").toString()));
				sMsg = sMsg + ")";
				
				rowData.put("amtRemark",  sMsg);
				logger.debug("여신초과 메시지 : " + rowData.get("amtRemark"));
				
				int upCnt = 0;
				if ("Y".equals(headCreditYn))
					// 본사통합여신 기준 업데이트
					upCnt = orderRequestUploadDAO.updateCreInfo2(rowData);
				else
					// 단일업장여신 기준 업데이트
					upCnt = orderRequestUploadDAO.updateCreInfo(rowData);
				logger.debug("Update : " + upCnt);
			}
		}
		
		
		logger.debug("### prNum : " + prNum);
		//List<Map> temp = orderRequestUploadDAO.select(row);
		/*소숫점발주통제 쿼리 변경 2021.12.07*/
		
		String hnrUpjangYn = "N";
		row.put("schUpjang", rcUpjang);
		
		hnrUpjangYn = orderRequestUploadDAO.selectHnrUpjangYn(row);
		row.put("hnrUpjangYn", hnrUpjangYn);
		
		
		List<Map> temp = orderRequestUploadDAO.selectExcelList(row);
		logger.debug("tempsize : " + temp.size());
		logger.debug("##########");
		logger.debug("##########");
		for (int i = 0; i < temp.size(); i++) {
			Map<String, Object> rowData = temp.get(i);
			if("N".equals(rowData.get("error").toString())){
				listSet.add(rowData);
			}else{
				errorSet.add(rowData);
			}
		}
		
		
		rsMap.put("dsList", listSet);
		rsMap.put("dsListError", errorSet);
		
		
		return rsMap;
	}
	
	
	/**
	 * 주문 엑셀업로드 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 구매유형 : 식자재_식재영업(FS) : 07 자료 기준 
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public Map<String, List> saveListTest(DataSetMap list,LoginDTO loginDTO) throws Exception {
		Map<String, List> rsMap = new HashMap<String, List>();
		List<Map<String, Object>> listSet = new ArrayList();
		List<Map<String, Object>> errorSet = new ArrayList(); 
		List<Map> listMap = new ArrayList<Map>();
		logger.debug("loginDTO : " + loginDTO);
		/*	엑셀 업로드시 PR_NUM 을 생성한다.	*/
		Map<String, Object> row = list.get(0);
		String prNum = orderRequestUploadDAO.excelPrNum(row);
		logger.debug("prNum : " + prNum);
		int inCnt = 0;
		int[] inCnts = null;
		/*	엑셀 리스트를 TEMP 테이블에 INSERT	*/
		for (int i = 0; i < list.size(); i++) {
			Map<String, Object> rowData = list.get(i);
			rowData.put("prNum", prNum);
			listMap.add(rowData);
		}
		if(listMap.size() == 0){
			throw new BizException("오류가 발생하였습니다. 재업로드 해주세요.\n(업로드할 데이터가 없습니다.)");
		}else{
			inCnts = orderRequestUploadDAO.tempInsert(listMap);
		}
		
		String apNum = orderRequestDAO.selectApNum(row);
		row.put("approveNum", apNum);
		
		/*	엑셀 리스트와 INSERT 건수가 다르면 에러발생.	*/
		if(inCnts.length != list.size()){
			throw new BizException("오류가 발생하였습니다. 재업로드 해주세요.\n(저장한 데이터와 실데이터가 다름.)");
		}
		inCnt = orderRequestUploadDAO.tempUpdate(row);
		logger.debug("temp_update : " + inCnt);
		inCnt = orderRequestUploadDAO.insert(row);
		logger.debug("fms_so_pr_temp insert : " + inCnt);
		
		logger.debug("##########");
		logger.debug("##########");
		
		row.put("prNum", prNum);
		
		/** 
		 * 	여신 체크 :  2015-11-30, 여신체크 단위를 본사, 본사통합여신 기준으로 체크
		 * 																**/
		// 여신체크 변수
		String headCreditYn = "";
		DecimalFormat df = new DecimalFormat("#,##0");

		List<Map> groupUpjang = orderRequestUploadDAO.upjangGroup(row);
		
		logger.debug("groupUpjang.size() : " + groupUpjang.size());
		
		for (int i = 0; i < groupUpjang.size(); i++) {
			Map<String, Object> rowData = groupUpjang.get(i);
			/*
			logger.debug("groupUpjang : " + groupUpjang.size() + "		:  " + i );
			
			headCreditYn = rowData.get("headCreditYn").toString();
			
			//=============================================
			// 여신기준일자 CHECK  : 2015-12-24
			//=============================================
			RecordSet rsDate;
			// 기준일자 SET
			if(("Y").equals(rowData.get("headCreditYn")))
				rsDate = orderRequestUploadDAO.selectNeedDate(rowData);
			else
				rsDate = orderRequestUploadDAO.selectNeedDate2(rowData);

			if (rsDate.size() > 0)
			{
				Map map = rsDate.get(0);
				// DEBUG --- 2
				logger.debug(" 기준일자 변경 후");
				logger.debug(" - needDate => " + map.get("needDate").toString());
				
				rowData.put("needDate", map.get("needDate").toString());
			}
			//=============================================
			
			logger.debug("$$$$$$$$$$$$$$");
			*/
			
			Map<String, Object> creInfo = orderRequestUploadDAO.selectCreInfoTest(rowData);
			// 본사통합여신 및 미통합 구분 체크
			// 여신체크여부(CREDIT_CONTROL_YN)에 대한 여부는 PASS, 여신관리 여부(필요 시 upjangGroup QUERY에 필드 추가 후 CHECK)
			if ("Y".equals(headCreditYn)) {
				logger.debug("=====본사통합여신=====");
				logger.debug(rowData.get("mainUpjang")+" : " + rowData.get("amt"));
				logger.debug(rowData.get("mainUpjang")+" : " + creInfo.get("creditAvailAmt"));
			} else {
				logger.debug("=====단일업장여신=====");
				logger.debug(rowData.get("rcUpjang")+" : " + rowData.get("amt"));
				logger.debug(rowData.get("rcUpjang")+" : " + creInfo.get("creditAvailAmt"));
			}
			if(Double.valueOf(rowData.get("amt").toString()) > Double.valueOf((creInfo.get("creditAvailAmt").toString()))){
				logger.debug("여신초과");
				// 여신초과 메시지
				String sMsg = "";
				sMsg = "(";
				sMsg = sMsg + "주문가능 : " + df.format(Double.valueOf(creInfo.get("creditAvailAmt").toString()));
				sMsg = sMsg + ", 판매금액 : " + df.format(Double.valueOf(rowData.get("amt").toString()));
				sMsg = sMsg + ")";
				
				rowData.put("amtRemark",  sMsg);
				logger.debug("여신초과 메시지 : " + rowData.get("amtRemark"));
				
				int upCnt = 0;
				
				if ("Y".equals(headCreditYn))
					// 본사통합여신 기준 업데이트
					upCnt = orderRequestUploadDAO.updateCreInfo2(rowData);
				else
					// 단일업장여신 기준 업데이트
					upCnt = orderRequestUploadDAO.updateCreInfo(rowData);
				
				logger.debug("Update : " + upCnt);
			}
		}
		
		
		logger.debug("### prNum : " + prNum);
		List<Map> temp = orderRequestUploadDAO.select(row);
		logger.debug("tempsize : " + temp.size());
		logger.debug("##########");
		logger.debug("##########");
		for (int i = 0; i < temp.size(); i++) {
			Map<String, Object> rowData = temp.get(i);
			if("N".equals(rowData.get("error").toString())){
				listSet.add(rowData);
			}else{
				errorSet.add(rowData);
			}
		}
		
		
		rsMap.put("dsList", listSet);
		rsMap.put("dsListError", errorSet);
		
		
		return rsMap;
	}


	/**
	 * 주문 엑셀업로드 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 구매유형 : 식자재_식재영업(FS) : 07 자료 기준 
	 *   [PJT]주문채널통합
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public Map<String, List> saveListBrand(DataSetMap list,LoginDTO loginDTO) throws Exception {
		Map<String, List> rsMap = new HashMap<String, List>();
		List<Map<String, Object>> listSet = new ArrayList();
		List<Map<String, Object>> errorSet = new ArrayList(); 
		List<Map> listMap = new ArrayList<Map>();
		
		logger.debug("loginDTO : " + loginDTO);
		
		/*	엑셀 업로드시 PR_NUM 을 생성한다.	*/
		Map<String, Object> row = list.get(0);
		String prNum = orderRequestUploadDAO.excelPrNum(row);
		logger.debug("prNum : " + prNum);
		
		int inCnt = 0;
		int[] inCnts = null;
		
		/*	엑셀 리스트를 TEMP 테이블에 INSERT	*/
		for (int i = 0; i < list.size(); i++) {
			Map<String, Object> rowData = list.get(i);
			rowData.put("prNum", prNum);
			listMap.add(rowData);
		}
		if(listMap.size() == 0){
			throw new BizException("오류가 발생하였습니다. 재업로드 해주세요.\n(업로드할 데이터가 없습니다.)");
		}else{
			inCnts = orderRequestUploadDAO.tempBrandInsert(listMap);
		}
		
		String apNum = orderRequestDAO.selectApNum(row);
		row.put("approveNum", apNum);
		
		/*	엑셀 리스트와 INSERT 건수가 다르면 에러발생.	*/
		if(inCnts.length != list.size()){
			throw new BizException("오류가 발생하였습니다. 재업로드 해주세요.\n(저장한 데이터와 실데이터가 다름.)");
		}
		
		// 브랜드유통업장 유저 정보  role 체크
		String isBrnadUserYn = loginDTO.getUserRoles().indexOf("브랜드유통") < 0 ? "N" : "Y";
		row.put("isBrnadUserYn",isBrnadUserYn);
		
		inCnt = orderRequestUploadDAO.tempUpdate(row);
		logger.debug("temp_update : " + inCnt);
		inCnt = orderRequestUploadDAO.insertBrand(row);
		logger.debug("fms_so_pr_temp insert : " + inCnt);
		
		logger.debug("##########");
		logger.debug("##########");
		
		row.put("prNum", prNum);
		
		/** 
		 * 	여신 체크 :  2015-11-30, 여신체크 단위를 본사, 본사통합여신 기준으로 체크
		 * 																**/
		// 여신체크 변수
		String headCreditYn = "";
		DecimalFormat df = new DecimalFormat("#,##0");
		
		List<Map> groupUpjang = orderRequestUploadDAO.upjangGroup(row);
		logger.debug("groupUpjang.size() : " + groupUpjang.size());
		
		for (int i = 0; i < groupUpjang.size(); i++) {
			Map<String, Object> rowData = groupUpjang.get(i);
			logger.debug("groupUpjang : " + groupUpjang.size() + "		:  " + i );
			
			headCreditYn = rowData.get("headCreditYn").toString();
			
// [속도개선 Project 시작] 2017. 8. 21. 최범주 여신정보조회 함수 대체
//			//=============================================
//			// 여신기준일자 CHECK  : 2015-12-24
//			//=============================================
//			RecordSet rsDate;
//			// 기준일자 SET
//			if(("Y").equals(rowData.get("headCreditYn")))
//				rsDate = orderRequestUploadDAO.selectNeedDate(rowData);
//			else
//				rsDate = orderRequestUploadDAO.selectNeedDate2(rowData);
//
//			if (rsDate.size() > 0)
//			{
//				Map map = rsDate.get(0);
//				// DEBUG --- 2
//				logger.debug(" 기준일자 변경 후");
//				logger.debug(" - needDate => " + map.get("needDate").toString());
//				
//				rowData.put("needDate", map.get("needDate").toString());
//			}
//			//=============================================
//			
//			
//			Map<String, Object> creInfo = orderRequestUploadDAO.selectCreInfo(rowData);
			Map<String, Object> inParam = new HashMap<String, Object>();
			inParam.put("schUpjang", rowData.get("rcUpjang").toString());
			inParam.put("schNeedDate", rowData.get("needDate").toString());
			Map<String, Object> creInfo = orderRequestDAO.selectCreInfo(inParam).get(0);
// [속도개선 Project   끝] 2017. 8. 21. 최범주
			// 본사통합여신 및 미통합 구분 체크
			// 여신체크여부(CREDIT_CONTROL_YN)에 대한 여부는 PASS, 여신관리 여부(필요 시 upjangGroup QUERY에 필드 추가 후 CHECK)
			if ("Y".equals(headCreditYn)) {
				logger.debug("=====본사통합여신=====");
				logger.debug(rowData.get("mainUpjang")+" : " + rowData.get("amt"));
				logger.debug(rowData.get("mainUpjang")+" : " + creInfo.get("creditAvailAmt"));
			} else {
				logger.debug("=====단일업장여신=====");
				logger.debug(rowData.get("rcUpjang")+" : " + rowData.get("amt"));
				logger.debug(rowData.get("rcUpjang")+" : " + creInfo.get("creditAvailAmt"));
			}
			if(Double.valueOf(rowData.get("amt").toString()) > Double.valueOf((creInfo.get("creditAvailAmt").toString()))){
				logger.debug("여신초과");
				// 여신초과 메시지
				String sMsg = "";
				sMsg = "(";
				sMsg = sMsg + "주문가능 : " + df.format(Double.valueOf(creInfo.get("creditAvailAmt").toString()));
				sMsg = sMsg + ", 판매금액 : " + df.format(Double.valueOf(rowData.get("amt").toString()));
				sMsg = sMsg + ")";
				
				rowData.put("amtRemark",  sMsg);
				logger.debug("여신초과 메시지 : " + rowData.get("amtRemark"));
				
				int upCnt = 0;
				if ("Y".equals(headCreditYn))
					// 본사통합여신 기준 업데이트
					upCnt = orderRequestUploadDAO.updateCreInfo2(rowData);
				else
					// 단일업장여신 기준 업데이트
					upCnt = orderRequestUploadDAO.updateCreInfo(rowData);
				logger.debug("Update : " + upCnt);
			}
		}
		
		logger.debug("### prNum : " + prNum);
		List<Map> temp = orderRequestUploadDAO.selectBrand(row);
		logger.debug("tempsize : " + temp.size());
		logger.debug("##########");
		logger.debug("##########");
		for (int i = 0; i < temp.size(); i++) {
			Map<String, Object> rowData = temp.get(i);
			if("N".equals(rowData.get("error").toString())){
				listSet.add(rowData);
			}else{
				errorSet.add(rowData);
			}
		}
		
		
		rsMap.put("dsList", listSet);
		rsMap.put("dsListError", errorSet);
		
		
		return rsMap;
	}
	
	/**
	 * Moadam 주문 엑셀업로드 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 구매유형 : 식자재_식재영업(FS) : 07 자료 기준 
	 * Moadam 주문 업로드
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public Map<String, List> saveListMoadam(DataSetMap list,LoginDTO loginDTO) throws Exception {
		Map<String, List> rsMap = new HashMap<String, List>();
		List<Map<String, Object>> listSet = new ArrayList();
		List<Map<String, Object>> errorSet = new ArrayList(); 
		List<Map> listMap = new ArrayList<Map>();
		logger.debug("loginDTO : " + loginDTO);
		/*	엑셀 업로드시 PR_NUM 을 생성한다.	*/
		Map<String, Object> row = list.get(0);
		String prNum = orderRequestUploadDAO.excelPrNum(row);
		logger.debug("prNum : " + prNum);
		int inCnt = 0;
		int[] inCnts = null;
		/*	엑셀 리스트를 TEMP 테이블에 INSERT	*/
		for (int i = 0; i < list.size(); i++) {
			Map<String, Object> rowData = list.get(i);
			rowData.put("prNum", prNum);
			listMap.add(rowData);
		}
		if(listMap.size() == 0){
			throw new BizException("오류가 발생하였습니다. 재업로드 해주세요.\n(업로드할 데이터가 없습니다.)");
		}else{
			/*#######*/
			inCnts = orderRequestUploadDAO.tempMoadamInsert(listMap);
		}
		
		String apNum = orderRequestDAO.selectApNum(row);
		row.put("approveNum", apNum);
		
		/*	엑셀 리스트와 INSERT 건수가 다르면 에러발생.	*/
		if(inCnts.length != list.size()){
			throw new BizException("오류가 발생하였습니다. 재업로드 해주세요.\n(저장한 데이터와 실데이터가 다름.)");
		}
		inCnt = orderRequestUploadDAO.tempUpdate(row);
		logger.debug("temp_update : " + inCnt);
		/*#######*/
		inCnt = orderRequestUploadDAO.insertMoadam(row);
		logger.debug("fms_so_pr_temp insert : " + inCnt);
		
		logger.debug("##########");
		logger.debug("##########");
		
		row.put("prNum", prNum);
		
		/** 
		 * 	여신 체크 :  2015-11-30, 여신체크 단위를 본사, 본사통합여신 기준으로 체크
		 * 																**/
		// 여신체크 변수
		String headCreditYn = "";
		DecimalFormat df = new DecimalFormat("#,##0");
		
		List<Map> groupUpjang = orderRequestUploadDAO.upjangGroup(row);
		logger.debug("groupUpjang.size() : " + groupUpjang.size());
		
		for (int i = 0; i < groupUpjang.size(); i++) {
			Map<String, Object> rowData = groupUpjang.get(i);
			logger.debug("groupUpjang : " + groupUpjang.size() + "		:  " + i );
			
			headCreditYn = rowData.get("headCreditYn").toString();
			
// [속도개선 Project 시작] 2017. 8. 21. 최범주 여신정보조회 함수 대체
//			//=============================================
//			// 여신기준일자 CHECK  : 2015-12-24
//			//=============================================
//			RecordSet rsDate;
//			// 기준일자 SET
//			if(("Y").equals(rowData.get("headCreditYn")))
//				rsDate = orderRequestUploadDAO.selectNeedDate(rowData);
//			else
//				rsDate = orderRequestUploadDAO.selectNeedDate2(rowData);
//
//			if (rsDate.size() > 0)
//			{
//				Map map = rsDate.get(0);
//				// DEBUG --- 2
//				logger.debug(" 기준일자 변경 후");
//				logger.debug(" - needDate => " + map.get("needDate").toString());
//				
//				rowData.put("needDate", map.get("needDate").toString());
//			}
//			//=============================================
//			
//			
//			Map<String, Object> creInfo = orderRequestUploadDAO.selectCreInfo(rowData);
			Map<String, Object> inParam = new HashMap<String, Object>();
			inParam.put("schUpjang", rowData.get("rcUpjang").toString());
			inParam.put("schNeedDate", rowData.get("needDate").toString());
			Map<String, Object> creInfo = orderRequestDAO.selectCreInfo(inParam).get(0);
// [속도개선 Project   끝] 2017. 8. 21. 최범주
			// 본사통합여신 및 미통합 구분 체크
			// 여신체크여부(CREDIT_CONTROL_YN)에 대한 여부는 PASS, 여신관리 여부(필요 시 upjangGroup QUERY에 필드 추가 후 CHECK)
			if ("Y".equals(headCreditYn)) {
				logger.debug("=====본사통합여신=====");
				logger.debug(rowData.get("mainUpjang")+" : " + rowData.get("amt"));
				logger.debug(rowData.get("mainUpjang")+" : " + creInfo.get("creditAvailAmt"));
			} else {
				logger.debug("=====단일업장여신=====");
				logger.debug(rowData.get("rcUpjang")+" : " + rowData.get("amt"));
				logger.debug(rowData.get("rcUpjang")+" : " + creInfo.get("creditAvailAmt"));
			}
			if(Double.valueOf(rowData.get("amt").toString()) > Double.valueOf((creInfo.get("creditAvailAmt").toString()))){
				logger.debug("여신초과");
				// 여신초과 메시지
				String sMsg = "";
				sMsg = "(";
				sMsg = sMsg + "주문가능 : " + df.format(Double.valueOf(creInfo.get("creditAvailAmt").toString()));
				sMsg = sMsg + ", 판매금액 : " + df.format(Double.valueOf(rowData.get("amt").toString()));
				sMsg = sMsg + ")";
				
				rowData.put("amtRemark",  sMsg);
				logger.debug("여신초과 메시지 : " + rowData.get("amtRemark"));
				
				int upCnt = 0;
				if ("Y".equals(headCreditYn))
					// 본사통합여신 기준 업데이트
					upCnt = orderRequestUploadDAO.updateCreInfo2(rowData);
				else
					// 단일업장여신 기준 업데이트
					upCnt = orderRequestUploadDAO.updateCreInfo(rowData);
				logger.debug("Update : " + upCnt);
			}
		}
		
		
		logger.debug("### prNum : " + prNum);
		/*#######*/
		List<Map> temp = orderRequestUploadDAO.selectMoadam(row);
		logger.debug("tempsize : " + temp.size());
		logger.debug("##########");
		logger.debug("##########");
		for (int i = 0; i < temp.size(); i++) {
			Map<String, Object> rowData = temp.get(i);
			if("N".equals(rowData.get("error").toString())){
				listSet.add(rowData);
			}else{
				errorSet.add(rowData);
			}
		}
		
		
		rsMap.put("dsList", listSet);
		rsMap.put("dsListError", errorSet);
		
		
		return rsMap;
	}
	
	/**
	 * Moadam 주문 엑셀업로드 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 구매유형 : 식자재_식재영업_긴급 : 29 모아담 자료 기준 
	 * Moadam 주문 업로드
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public Map<String, List> saveListMoadam29(DataSetMap list,LoginDTO loginDTO) throws Exception {
		Map<String, List> rsMap = new HashMap<String, List>();
		List<Map<String, Object>> listSet = new ArrayList();
		List<Map<String, Object>> errorSet = new ArrayList(); 
		List<Map> listMap = new ArrayList<Map>();
		logger.debug("loginDTO : " + loginDTO);
		/*	엑셀 업로드시 PR_NUM 을 생성한다.	*/
		Map<String, Object> row = list.get(0);
		String prNum = orderRequestUploadDAO.excelPrNum(row);
		logger.debug("prNum : " + prNum);
		int inCnt = 0;
		int[] inCnts = null;
		/*	엑셀 리스트를 TEMP 테이블에 INSERT	*/
		for (int i = 0; i < list.size(); i++) {
			Map<String, Object> rowData = list.get(i);
			rowData.put("prNum", prNum);
			listMap.add(rowData);
		}
		if(listMap.size() == 0){
			throw new BizException("오류가 발생하였습니다. 재업로드 해주세요.\n(업로드할 데이터가 없습니다.)");
		}else{
			/*#######*/
			inCnts = orderRequestUploadDAO.tempMoadamInsert(listMap);
		}
		
		String apNum = orderRequestDAO.selectApNum(row);
		row.put("approveNum", apNum);
		
		/*	엑셀 리스트와 INSERT 건수가 다르면 에러발생.	*/
		if(inCnts.length != list.size()){
			throw new BizException("오류가 발생하였습니다. 재업로드 해주세요.\n(저장한 데이터와 실데이터가 다름.)");
		}
		inCnt = orderRequestUploadDAO.tempUpdate(row);
		logger.debug("temp_update : " + inCnt);
		/*#######*/
		inCnt = orderRequestUploadDAO.insertMoadam29(row);
		logger.debug("fms_so_pr_temp insert : " + inCnt);
		
		logger.debug("##########");
		logger.debug("##########");
		
		row.put("prNum", prNum);
		
		/** 
		 * 	여신 체크 :  2015-11-30, 여신체크 단위를 본사, 본사통합여신 기준으로 체크
		 * 																**/
		// 여신체크 변수
		String headCreditYn = "";
		DecimalFormat df = new DecimalFormat("#,##0");
		
		List<Map> groupUpjang = orderRequestUploadDAO.upjangGroup(row);
		logger.debug("groupUpjang.size() : " + groupUpjang.size());
		
		for (int i = 0; i < groupUpjang.size(); i++) {
			Map<String, Object> rowData = groupUpjang.get(i);
			logger.debug("groupUpjang : " + groupUpjang.size() + "		:  " + i );
			
			headCreditYn = rowData.get("headCreditYn").toString();
			
// [속도개선 Project 시작] 2017. 8. 21. 최범주 여신정보조회 함수 대체
//			//=============================================
//			// 여신기준일자 CHECK  : 2015-12-24
//			//=============================================
//			RecordSet rsDate;
//			// 기준일자 SET
//			if(("Y").equals(rowData.get("headCreditYn")))
//				rsDate = orderRequestUploadDAO.selectNeedDate(rowData);
//			else
//				rsDate = orderRequestUploadDAO.selectNeedDate2(rowData);
//
//			if (rsDate.size() > 0)
//			{
//				Map map = rsDate.get(0);
//				// DEBUG --- 2
//				logger.debug(" 기준일자 변경 후");
//				logger.debug(" - needDate => " + map.get("needDate").toString());
//				
//				rowData.put("needDate", map.get("needDate").toString());
//			}
//			//=============================================
//			
//			
//			Map<String, Object> creInfo = orderRequestUploadDAO.selectCreInfo(rowData);
			Map<String, Object> inParam = new HashMap<String, Object>();
			inParam.put("schUpjang", rowData.get("rcUpjang").toString());
			inParam.put("schNeedDate", rowData.get("needDate").toString());
			Map<String, Object> creInfo = orderRequestDAO.selectCreInfo(inParam).get(0);
// [속도개선 Project   끝] 2017. 8. 21. 최범주
			// 본사통합여신 및 미통합 구분 체크
			// 여신체크여부(CREDIT_CONTROL_YN)에 대한 여부는 PASS, 여신관리 여부(필요 시 upjangGroup QUERY에 필드 추가 후 CHECK)
			if ("Y".equals(headCreditYn)) {
				logger.debug("=====본사통합여신=====");
				logger.debug(rowData.get("mainUpjang")+" : " + rowData.get("amt"));
				logger.debug(rowData.get("mainUpjang")+" : " + creInfo.get("creditAvailAmt"));
			} else {
				logger.debug("=====단일업장여신=====");
				logger.debug(rowData.get("rcUpjang")+" : " + rowData.get("amt"));
				logger.debug(rowData.get("rcUpjang")+" : " + creInfo.get("creditAvailAmt"));
			}
			if(Double.valueOf(rowData.get("amt").toString()) > Double.valueOf((creInfo.get("creditAvailAmt").toString()))){
				logger.debug("여신초과");
				// 여신초과 메시지
				String sMsg = "";
				sMsg = "(";
				sMsg = sMsg + "주문가능 : " + df.format(Double.valueOf(creInfo.get("creditAvailAmt").toString()));
				sMsg = sMsg + ", 판매금액 : " + df.format(Double.valueOf(rowData.get("amt").toString()));
				sMsg = sMsg + ")";
				
				rowData.put("amtRemark",  sMsg);
				logger.debug("여신초과 메시지 : " + rowData.get("amtRemark"));
				
				int upCnt = 0;
				if ("Y".equals(headCreditYn))
					// 본사통합여신 기준 업데이트
					upCnt = orderRequestUploadDAO.updateCreInfo2(rowData);
				else
					// 단일업장여신 기준 업데이트
					upCnt = orderRequestUploadDAO.updateCreInfo(rowData);
				logger.debug("Update : " + upCnt);
			}
		}
		
		
		logger.debug("### prNum : " + prNum);
		/*#######*/
		List<Map> temp = orderRequestUploadDAO.selectMoadam(row);
		logger.debug("tempsize : " + temp.size());
		logger.debug("##########");
		logger.debug("##########");
		for (int i = 0; i < temp.size(); i++) {
			Map<String, Object> rowData = temp.get(i);
			if("N".equals(rowData.get("error").toString())){
				listSet.add(rowData);
			}else{
				errorSet.add(rowData);
			}
		}
		
		
		rsMap.put("dsList", listSet);
		rsMap.put("dsListError", errorSet);
		
		
		return rsMap;
	}
	
	/**
	 * 주문 엑셀업로드 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 구매유형 : 식자재_식재영업_긴급 : 29 자료 기준 
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public Map<String, List> saveList2(DataSetMap list,LoginDTO loginDTO) throws Exception {
		Map<String, List> rsMap = new HashMap<String, List>();
		List<Map<String, Object>> listSet = new ArrayList();
		List<Map<String, Object>> errorSet = new ArrayList(); 
		List<Map> listMap = new ArrayList<Map>();
		logger.debug("loginDTO : " + loginDTO);
		/*	엑셀 업로드시 PR_NUM 을 생성한다.	*/
		Map<String, Object> row = list.get(0);
		String prNum = orderRequestUploadDAO.excelPrNum(row);
		logger.debug("prNum : " + prNum);
		int inCnt = 0;
		int[] inCnts = null;
		/*	엑셀 리스트를 TEMP 테이블에 INSERT	*/
		for (int i = 0; i < list.size(); i++) {
			Map<String, Object> rowData = list.get(i);
			rowData.put("prNum", prNum);
			listMap.add(rowData);
		}
		if(listMap.size() == 0){
			throw new BizException("오류가 발생하였습니다. 재업로드 해주세요.\n(업로드할 데이터가 없습니다.)");
		}else{
			inCnts = orderRequestUploadDAO.tempInsert(listMap);
		}
		
		String apNum = orderRequestDAO.selectApNum(row);
		row.put("approveNum", apNum);
		
		/*	엑셀 리스트와 INSERT 건수가 다르면 에러발생.	*/
		if(inCnts.length != list.size()){
			throw new BizException("오류가 발생하였습니다. 재업로드 해주세요.\n(저장한 데이터와 실데이터가 다름.)");
		}
		inCnt = orderRequestUploadDAO.tempUpdate(row);
		logger.debug("temp_update : " + inCnt);
		// 식재영업_긴급(29) 관련 INSERT
		inCnt = orderRequestUploadDAO.insert29(row);
		logger.debug("fms_so_pr_temp insert : " + inCnt);
		
		logger.debug("##########");
		logger.debug("##########");
		
		row.put("prNum", prNum);
		
		/** 
		 * 	여신 체크 :  2015-11-30, 여신체크 단위를 본사, 본사통합여신 기준으로 체크
		 * 																**/
		// 여신체크 변수
		String headCreditYn = "";
		DecimalFormat df = new DecimalFormat("#,##0");
		
		String rcUpjang = "";

		List<Map> groupUpjang = orderRequestUploadDAO.upjangGroup(row);
		for (int i = 0; i < groupUpjang.size(); i++) {
			Map<String, Object> rowData = groupUpjang.get(i);
			logger.debug("groupUpjang : " + groupUpjang.size() + "		:  " + i );
			
			headCreditYn = rowData.get("headCreditYn").toString();

// [속도개선 Project 시작] 2017. 8. 21. 최범주 여신정보조회 함수 대체			
//			//=============================================
//			// 여신기준일자 CHECK  : 2015-12-24
//			//=============================================
//			RecordSet rsDate;
//			// 기준일자 SET
//			if(("Y").equals(rowData.get("headCreditYn")))
//				rsDate = orderRequestUploadDAO.selectNeedDate(rowData);
//			else
//				rsDate = orderRequestUploadDAO.selectNeedDate2(rowData);
//
//			if (rsDate.size() > 0)
//			{
//				Map map = rsDate.get(0);
//				// DEBUG --- 2
//				logger.debug(" 기준일자 변경 후");
//				logger.debug(" - needDate => " + map.get("needDate").toString());
//				
//				rowData.put("needDate", map.get("needDate").toString());
//			}
//			//=============================================
//			
//			
//			Map<String, Object> creInfo = orderRequestUploadDAO.selectCreInfo(rowData);
			Map<String, Object> inParam = new HashMap<String, Object>();
			inParam.put("schUpjang", rowData.get("rcUpjang").toString());
			inParam.put("schNeedDate", rowData.get("needDate").toString());
			Map<String, Object> creInfo = orderRequestDAO.selectCreInfo(inParam).get(0);
			
			rcUpjang = rowData.get("rcUpjang").toString();
			
// [속도개선 Project   끝] 2017. 8. 21. 최범주
			// 본사통합여신 및 미통합 구분 체크
			// 여신체크여부(CREDIT_CONTROL_YN)에 대한 여부는 PASS, 여신관리 여부(필요 시 upjangGroup QUERY에 필드 추가 후 CHECK)
			if ("Y".equals(headCreditYn)) {
				logger.debug("=====본사통합여신=====");
				logger.debug(rowData.get("mainUpjang")+" : " + rowData.get("amt"));
				logger.debug(rowData.get("mainUpjang")+" : " + creInfo.get("creditAvailAmt"));
			} else {
				logger.debug("=====단일업장여신=====");
				logger.debug(rowData.get("rcUpjang")+" : " + rowData.get("amt"));
				logger.debug(rowData.get("rcUpjang")+" : " + creInfo.get("creditAvailAmt"));
			}
			if(Double.valueOf(rowData.get("amt").toString()) > Double.valueOf((creInfo.get("creditAvailAmt").toString()))){
				logger.debug("여신초과");
				// 여신초과 메시지
				String sMsg = "";
				sMsg = "(";
				sMsg = sMsg + "주문가능 : " + df.format(Double.valueOf(creInfo.get("creditAvailAmt").toString()));
				sMsg = sMsg + ", 판매금액 : " + df.format(Double.valueOf(rowData.get("amt").toString()));
				sMsg = sMsg + ")";
				
				rowData.put("amtRemark",  sMsg);
				logger.debug("여신초과 메시지 : " + rowData.get("amtRemark"));
				
				int upCnt = 0;
				if ("Y".equals(headCreditYn))
					// 본사통합여신 기준 업데이트
					upCnt = orderRequestUploadDAO.updateCreInfo2(rowData);
				else
					// 단일업장여신 기준 업데이트
					upCnt = orderRequestUploadDAO.updateCreInfo(rowData);
				logger.debug("Update : " + upCnt);
			}
		}
		
		
		logger.debug("### prNum : " + prNum);
		
		String hnrUpjangYn = "N";
		row.put("schUpjang", rcUpjang);
		
		// 임시주석으로 6월마감이후 재반영 예정
		//hnrUpjangYn = orderRequestUploadDAO.selectHnrUpjangYn(row);
		row.put("hnrUpjangYn", hnrUpjangYn);
		
		
		List<Map> temp = orderRequestUploadDAO.select(row);
		logger.debug("tempsize : " + temp.size());
		logger.debug("##########");
		logger.debug("##########");
		for (int i = 0; i < temp.size(); i++) {
			Map<String, Object> rowData = temp.get(i);
			if("N".equals(rowData.get("error").toString())){
				listSet.add(rowData);
			}else{
				errorSet.add(rowData);
			}
		}
		
		
		rsMap.put("dsList", listSet);
		rsMap.put("dsListError", errorSet);
		
		
		return rsMap;
	}
	

	/**
	 * 주문 엑셀업로드 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 구매유형 : 식자재_식재영업_긴급 : 29 자료 기준 
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public Map<String, List> saveList2Test(DataSetMap list,LoginDTO loginDTO) throws Exception {
		Map<String, List> rsMap = new HashMap<String, List>();
		List<Map<String, Object>> listSet = new ArrayList();
		List<Map<String, Object>> errorSet = new ArrayList(); 
		List<Map> listMap = new ArrayList<Map>();
		logger.debug("loginDTO : " + loginDTO);
		/*	엑셀 업로드시 PR_NUM 을 생성한다.	*/
		Map<String, Object> row = list.get(0);
		String prNum = orderRequestUploadDAO.excelPrNum(row);
		logger.debug("prNum : " + prNum);
		int inCnt = 0;
		int[] inCnts = null;
		/*	엑셀 리스트를 TEMP 테이블에 INSERT	*/
		for (int i = 0; i < list.size(); i++) {
			Map<String, Object> rowData = list.get(i);
			rowData.put("prNum", prNum);
			listMap.add(rowData);
		}
		if(listMap.size() == 0){
			throw new BizException("오류가 발생하였습니다. 재업로드 해주세요.\n(업로드할 데이터가 없습니다.)");
		}else{
			inCnts = orderRequestUploadDAO.tempInsert(listMap);
		}
		
		String apNum = orderRequestDAO.selectApNum(row);
		row.put("approveNum", apNum);
		
		/*	엑셀 리스트와 INSERT 건수가 다르면 에러발생.	*/
		if(inCnts.length != list.size()){
			throw new BizException("오류가 발생하였습니다. 재업로드 해주세요.\n(저장한 데이터와 실데이터가 다름.)");
		}
		inCnt = orderRequestUploadDAO.tempUpdate(row);
		logger.debug("temp_update : " + inCnt);
		// 식재영업_긴급(29) 관련 INSERT
		inCnt = orderRequestUploadDAO.insert29(row);
		logger.debug("fms_so_pr_temp insert : " + inCnt);
		
		logger.debug("##########");
		logger.debug("##########");
		
		row.put("prNum", prNum);
		
		/** 
		 * 	여신 체크 :  2015-11-30, 여신체크 단위를 본사, 본사통합여신 기준으로 체크
		 * 																**/
		// 여신체크 변수
		String headCreditYn = "";
		DecimalFormat df = new DecimalFormat("#,##0");

		List<Map> groupUpjang = orderRequestUploadDAO.upjangGroup(row);
		for (int i = 0; i < groupUpjang.size(); i++) {
			
			Map<String, Object> rowData = groupUpjang.get(i);
			/*
			logger.debug("groupUpjang : " + groupUpjang.size() + "		:  " + i );
			
			headCreditYn = rowData.get("headCreditYn").toString();

			//=============================================
			// 여신기준일자 CHECK  : 2015-12-24
			//=============================================
			RecordSet rsDate;
			// 기준일자 SET
			if(("Y").equals(rowData.get("headCreditYn")))
				rsDate = orderRequestUploadDAO.selectNeedDate(rowData);
			else
				rsDate = orderRequestUploadDAO.selectNeedDate2(rowData);

			if (rsDate.size() > 0)
			{
				Map map = rsDate.get(0);
				// DEBUG --- 2
				logger.debug(" 기준일자 변경 후");
				logger.debug(" - needDate => " + map.get("needDate").toString());
				
				rowData.put("needDate", map.get("needDate").toString());
			}
			//=============================================
			*/
			
			Map<String, Object> creInfo = orderRequestUploadDAO.selectCreInfoTest(rowData);
			// 본사통합여신 및 미통합 구분 체크
			// 여신체크여부(CREDIT_CONTROL_YN)에 대한 여부는 PASS, 여신관리 여부(필요 시 upjangGroup QUERY에 필드 추가 후 CHECK)
			if ("Y".equals(headCreditYn)) {
				logger.debug("=====본사통합여신=====");
				logger.debug(rowData.get("mainUpjang")+" : " + rowData.get("amt"));
				logger.debug(rowData.get("mainUpjang")+" : " + creInfo.get("creditAvailAmt"));
			} else {
				logger.debug("=====단일업장여신=====");
				logger.debug(rowData.get("rcUpjang")+" : " + rowData.get("amt"));
				logger.debug(rowData.get("rcUpjang")+" : " + creInfo.get("creditAvailAmt"));
			}
			if(Double.valueOf(rowData.get("amt").toString()) > Double.valueOf((creInfo.get("creditAvailAmt").toString()))){
				logger.debug("여신초과");
				// 여신초과 메시지
				String sMsg = "";
				sMsg = "(";
				sMsg = sMsg + "주문가능 : " + df.format(Double.valueOf(creInfo.get("creditAvailAmt").toString()));
				sMsg = sMsg + ", 판매금액 : " + df.format(Double.valueOf(rowData.get("amt").toString()));
				sMsg = sMsg + ")";
				
				rowData.put("amtRemark",  sMsg);
				logger.debug("여신초과 메시지 : " + rowData.get("amtRemark"));
				
				int upCnt = 0;
				if ("Y".equals(headCreditYn))
					// 본사통합여신 기준 업데이트
					upCnt = orderRequestUploadDAO.updateCreInfo2(rowData);
				else
					// 단일업장여신 기준 업데이트
					upCnt = orderRequestUploadDAO.updateCreInfo(rowData);
				logger.debug("Update : " + upCnt);
			}
		}
		
		
		logger.debug("### prNum : " + prNum);
		List<Map> temp = orderRequestUploadDAO.select(row);
		logger.debug("tempsize : " + temp.size());
		logger.debug("##########");
		logger.debug("##########");
		for (int i = 0; i < temp.size(); i++) {
			Map<String, Object> rowData = temp.get(i);
			if("N".equals(rowData.get("error").toString())){
				listSet.add(rowData);
			}else{
				errorSet.add(rowData);
			}
		}
		
		
		rsMap.put("dsList", listSet);
		rsMap.put("dsListError", errorSet);
		
		
		return rsMap;
	}
	
	/**
	 * 주문 엑셀업로드 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
// [속도개선 Project 시작] 2017. 8. 4. 최범주 여신금액 집계 프로시저 추가
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public RecordSet saveIfList(DataSetMap list, LoginDTO loginDTO) throws Exception {
		Map<String, Object> retProcVal = new HashMap<String, Object>();
		List<Map> listMap = new ArrayList<Map>();
		int inCnt = 0;
		int[] upCnts;
		RecordSet rs = null;
		
		double p_occur_amt        = 0;
		double p_occur_amt_before = 0;
		String p_key_nm         = "";
		Map<String, Object> map = null;
		double sellAmt          = 0;
		
		try{
			/** 상위 그리드만 처리 하게 업데이트 **/
			for (int i = 0; i < list.size(); i++) {
				Map<String, Object> rowData = list.get(i);
					listMap.add(rowData);
			}
			upCnts = orderRequestUploadDAO.update(listMap);
			logger.debug("upCnts : " + upCnts.length);
			/* FMS_SO_PR_TEMP - > SO_PR	*/
			inCnt = orderRequestUploadDAO.insert2(list.get(0));
			logger.debug("LIST : " + list.size());
			logger.debug("listMap : " + listMap.size());
			logger.debug("SO_PR insert : " + inCnt);
			if(upCnts.length != inCnt){
				throw new BizException("데이터 생성중 오류가 발생하였습니다.\n시스템 관리자에게 문의하세요.");
			}
			/* FMS_SO_PR_TEMP - > SO_PR	*/
			
			
			/* SO_PR - > GROUP BY RC_UPJANG,NEED_DATE	*/
			RecordSet glist = orderRequestUploadDAO.selectGroup(list.get(0));
			for (int i = 0; i < glist.size(); i++) {
				Map<String, Object> rowData = glist.get(i);
				String prNum = orderRequestUploadDAO.getprNum(rowData);//주문신청번호 생성  'B'+YYYYMMDD+SO_PR_NUM.NEXTVAL
				p_key_nm     = prNum;
				rowData.put("newPrNum", prNum);
				int upCnt = orderRequestUploadDAO.prNumUpdate(rowData);
				logger.debug("업데이트 건수  = " + upCnt);
				retProcVal = ifupdate(rowData,"C");
				if(!"S000".equals(retProcVal.get("O_RTN_CD").toString())){
					if(retProcVal.get("O_RTN_MSG") == null)retProcVal.put("O_RTN_MSG","("+rowData.get("subinvCode")+")"+"오류가 발생하였습니다.\n시스템 관리자에게 문의하세요.");
					throw new BizException("("+rowData.get("subinvCode")+")"+retProcVal.get("O_RTN_MSG").toString());
				}
				logger.debug("I/F CD  = " + retProcVal.get("O_RTN_MSG").toString());
				logger.debug("I/F MSG  = " + retProcVal.get("O_RTN_CD").toString());
				rowData.put("rtnMsg", retProcVal.get("O_RTN_MSG").toString());
				rowData.put("rtnCd", retProcVal.get("O_RTN_CD").toString());
				orderRequestUploadDAO.prNumUpdateIF(rowData);//구매 IF 결과 저장
				
				// 구매 프로시저 처리가 성공일 경우
				if ( ValidationUtil.isEquals(retProcVal.get("O_RTN_CD").toString(), Const.PURC_PROC_SUCC) ) {

					//발생전 금액 초기화
					p_occur_amt = 0;
					
					for ( int j = 0; j < list.size(); j++ ) {
						map = list.get(j);
						
						if (   ValidationUtil.isEquals(map.get("rcUpjang").toString(), rowData.get("rcUpjang").toString()) 
						    && ValidationUtil.isEquals(map.get("needDate").toString(), rowData.get("needDate").toString()) 
						   ) {
							sellAmt = Double.parseDouble(map.get("salePrice").toString()) * Double.parseDouble(map.get("prQty").toString());  
							// 과세일 경우
							if ( ValidationUtil.isEquals(map.get("taxCode").toString(), Const.TXN_CLSS_100) ) {
								p_occur_amt += Math.round(sellAmt * 1.1); 
							} else {
								p_occur_amt += Math.round(sellAmt);
							}
						}
					}

					Map<String, Object> rtnProcedure   = null;
					Map<String, Object> procedureParam = new HashMap<String, Object>();
					procedureParam.put("p_upjang_cd",        rowData.get("rcUpjang").toString());  // (필수)업장코드
					procedureParam.put("p_apply_date",       rowData.get("needDate").toString());  // (필수)적용일자(발주시:입고예정일 입금처리시: 입금일자 마감시:매출일자)
					procedureParam.put("p_occur_class",      "01");                                // (필수)발생구분(01:매입예정 02:매입확정 03:외상매출금)
					procedureParam.put("p_occur_amt",        p_occur_amt);                         // (필수)발생금액
					procedureParam.put("p_occur_amt_before", p_occur_amt_before);                  // (필수)발생금액(전)
					procedureParam.put("p_class_cd",         "01");                                // (필수)구분코드(01:주문신청관련 02:매출보정 03:판매단가변경 04:창고 강제변경 05:현지구매 06:영업회계 일마감 07:채권이관/입금처리)
					procedureParam.put("p_occur_table",      "SO_PR");                             // (필수)발생테이블
					procedureParam.put("p_key_nm",           "PR_NUM");                            // (필수)키명
					procedureParam.put("p_key_value01",      p_key_nm);                            // (필수)키1(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
					procedureParam.put("p_key_value02",      "");                                  // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
					procedureParam.put("p_key_value03",      "");                                  // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
					procedureParam.put("p_key_value04",      "");                                  // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
					procedureParam.put("p_key_value05",      "");                                  // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
					procedureParam.put("p_occur_prg_id",     "OrderRequest");                      // 프로그램ID
					procedureParam.put("p_occur_prg_nm",     "주문신청");                          // 프로그램 한글명
					procedureParam.put("p_cuser",            loginDTO.getSabun());                 // 생성자
					rtnProcedure = orderRequestDAO.procLncrTtz(procedureParam);
					
					if ( !ValidationUtil.isEquals(rtnProcedure.get("o_rtn").toString(), Const.YN_Y) ) {
						throw new BusinessRuntimeException(rtnProcedure.get("o_rtnmsg").toString());
					}
				}
			}
			
			/* SO_PR 등록 결과를 조회한다.	*/
			rs = orderRequestUploadDAO.selectSopr(list.get(0));
			/** 정상 종료시 TEMP 삭제.	**/
			orderRequestUploadDAO.tempDelfms(list.get(0));//구매 IF 결과 저장
			/** 정상 종료시 EXCEL TEMP 삭제.	**/
			orderRequestUploadDAO.tempDelExcel(list.get(0));//TEMP_BIZ_EXCEL 삭제
			
		}catch(Exception e){
			throw new BizException(e.getMessage());
		}
		
		return rs;
	}
// [속도개선 Project   끝] 2017. 8. 4. 최범주
	
	/**
	 * 주문 엑셀업로드 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)
	 *   [PJT]주문채널통합
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	 */
// [속도개선 Project 시작] 2017. 8. 4. 최범주 여신금액 집계 프로시저 추가
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public RecordSet saveBrandIfList(DataSetMap list, LoginDTO loginDTO) throws Exception {
		Map<String, Object> retProcVal = new HashMap<String, Object>();
		List<Map> listMap = new ArrayList<Map>();
		int inCnt = 0;
		int[] upCnts;
		RecordSet rs = null;
		
		double p_occur_amt        = 0;
		double p_occur_amt_before = 0;
		String p_key_nm         = "";
		Map<String, Object> map = null;
		double sellAmt          = 0;
		
		try{
			/** 상위 그리드만 처리 하게 업데이트 **/
			for (int i = 0; i < list.size(); i++) {
				Map<String, Object> rowData = list.get(i);
				listMap.add(rowData);
			}
			upCnts = orderRequestUploadDAO.updateBrand(listMap);
			logger.debug("upCnts : " + upCnts.length);
			/* FMS_SO_PR_TEMP - > SO_PR	*/
			inCnt = orderRequestUploadDAO.insert2Brand(list.get(0));
			logger.debug("LIST : " + list.size());
			logger.debug("listMap : " + listMap.size());
			logger.debug("SO_PR insert : " + inCnt);
			if(upCnts.length != inCnt){
				throw new BizException("데이터 생성중 오류가 발생하였습니다.\n시스템 관리자에게 문의하세요.");
			}
			/* FMS_SO_PR_TEMP - > SO_PR	*/
			
			
			/* SO_PR - > GROUP BY RC_UPJANG,NEED_DATE	*/
			RecordSet glist = orderRequestUploadDAO.selectGroup(list.get(0));
			for (int i = 0; i < glist.size(); i++) {
				Map<String, Object> rowData = glist.get(i);
				String prNum = orderRequestUploadDAO.getprNum(rowData);//주문신청번호 생성  'B'+YYYYMMDD+SO_PR_NUM.NEXTVAL
				p_key_nm     = prNum;
				rowData.put("newPrNum", prNum);
				int upCnt = orderRequestUploadDAO.prNumUpdate(rowData);
				logger.debug("업데이트 건수  = " + upCnt);
				retProcVal = ifupdate(rowData,"C");
				if(!"S000".equals(retProcVal.get("O_RTN_CD").toString())){
					if(retProcVal.get("O_RTN_MSG") == null)retProcVal.put("O_RTN_MSG","("+rowData.get("subinvCode")+")"+"오류가 발생하였습니다.\n시스템 관리자에게 문의하세요.");
					throw new BizException("("+rowData.get("subinvCode")+")"+retProcVal.get("O_RTN_MSG").toString());
				}
				logger.debug("I/F CD  = " + retProcVal.get("O_RTN_MSG").toString());
				logger.debug("I/F MSG  = " + retProcVal.get("O_RTN_CD").toString());
				rowData.put("rtnMsg", retProcVal.get("O_RTN_MSG").toString());
				rowData.put("rtnCd", retProcVal.get("O_RTN_CD").toString());
				orderRequestUploadDAO.prNumUpdateIF(rowData);//구매 IF 결과 저장
				
				// 구매 프로시저 처리가 성공일 경우
				if ( ValidationUtil.isEquals(retProcVal.get("O_RTN_CD").toString(), Const.PURC_PROC_SUCC) ) {
					
					//발생전 금액 초기화
					p_occur_amt = 0;
					
					for ( int j = 0; j < list.size(); j++ ) {
						map = list.get(j);
						
						if (   ValidationUtil.isEquals(map.get("rcUpjang").toString(), rowData.get("rcUpjang").toString()) 
								&& ValidationUtil.isEquals(map.get("needDate").toString(), rowData.get("needDate").toString()) 
								) {
							sellAmt = Double.parseDouble(map.get("salePrice").toString()) * Double.parseDouble(map.get("prQty").toString());  
							// 과세일 경우
							if ( ValidationUtil.isEquals(map.get("taxCode").toString(), Const.TXN_CLSS_100) ) {
								p_occur_amt += Math.round(sellAmt * 1.1); 
							} else {
								p_occur_amt += Math.round(sellAmt);
							}
						}
					}
					
					Map<String, Object> rtnProcedure   = null;
					Map<String, Object> procedureParam = new HashMap<String, Object>();
					procedureParam.put("p_upjang_cd",        rowData.get("rcUpjang").toString());  // (필수)업장코드
					procedureParam.put("p_apply_date",       rowData.get("needDate").toString());  // (필수)적용일자(발주시:입고예정일 입금처리시: 입금일자 마감시:매출일자)
					procedureParam.put("p_occur_class",      "01");                                // (필수)발생구분(01:매입예정 02:매입확정 03:외상매출금)
					procedureParam.put("p_occur_amt",        p_occur_amt);                         // (필수)발생금액
					procedureParam.put("p_occur_amt_before", p_occur_amt_before);                  // (필수)발생금액(전)
					procedureParam.put("p_class_cd",         "01");                                // (필수)구분코드(01:주문신청관련 02:매출보정 03:판매단가변경 04:창고 강제변경 05:현지구매 06:영업회계 일마감 07:채권이관/입금처리)
					procedureParam.put("p_occur_table",      "SO_PR");                             // (필수)발생테이블
					procedureParam.put("p_key_nm",           "PR_NUM");                            // (필수)키명
					procedureParam.put("p_key_value01",      p_key_nm);                            // (필수)키1(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
					procedureParam.put("p_key_value02",      "");                                  // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
					procedureParam.put("p_key_value03",      "");                                  // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
					procedureParam.put("p_key_value04",      "");                                  // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
					procedureParam.put("p_key_value05",      "");                                  // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
					procedureParam.put("p_occur_prg_id",     "OrderRequest");                      // 프로그램ID
					procedureParam.put("p_occur_prg_nm",     "주문신청");                          // 프로그램 한글명
					procedureParam.put("p_cuser",            loginDTO.getSabun());                 // 생성자
					rtnProcedure = orderRequestDAO.procLncrTtz(procedureParam);
					
					if ( !ValidationUtil.isEquals(rtnProcedure.get("o_rtn").toString(), Const.YN_Y) ) {
						throw new BusinessRuntimeException(rtnProcedure.get("o_rtnmsg").toString());
					}
				}
			}
			
			/* SO_PR 등록 결과를 조회한다.	*/
			rs = orderRequestUploadDAO.selectSoprBrand(list.get(0));
			/** 정상 종료시 TEMP 삭제.	**/
			orderRequestUploadDAO.tempDelfms(list.get(0));//구매 IF 결과 저장
			/** 정상 종료시 EXCEL TEMP 삭제.	**/
			orderRequestUploadDAO.tempDelExcel(list.get(0));//TEMP_BIZ_EXCEL 삭제
			
		}catch(Exception e){
			throw new BizException(e.getMessage());
		}
		
		return rs;
	}
// [속도개선 Project   끝] 2017. 8. 4. 최범주
	
	/**
	 * 모아담 주문 엑셀업로드 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)
	 * 모아담 주문 업로드
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	 */
// [속도개선 Project 시작] 2017. 8. 4. 최범주 여신금액 집계 프로시저 추가
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public RecordSet saveMoadamIfList(DataSetMap list, LoginDTO loginDTO) throws Exception {
		Map<String, Object> retProcVal = new HashMap<String, Object>();
		List<Map> listMap = new ArrayList<Map>();
		int inCnt = 0;
		int[] upCnts;
		int[] upCnts2;
		RecordSet rs = null;
		
		double p_occur_amt        = 0;
		double p_occur_amt_before = 0;
		String p_key_nm         = "";
		Map<String, Object> map = null;
		double sellAmt          = 0;
		
		try{
			/** 상위 그리드만 처리 하게 업데이트 **/
			for (int i = 0; i < list.size(); i++) {
				Map<String, Object> rowData = list.get(i);
				listMap.add(rowData);
			}
			/*######*/
			upCnts = orderRequestUploadDAO.update(listMap);
			logger.debug("upCnts : " + upCnts.length);
			/* FMS_SO_PR_TEMP - > SO_PR	*/
			/*######*/
			inCnt = orderRequestUploadDAO.insert2(list.get(0));
			logger.debug("Moadam Order insert!");
			logger.debug("LIST : " + list.size());
			logger.debug("listMap : " + listMap.size());
			logger.debug("SO_PR insert : " + inCnt);
			if(upCnts.length != inCnt){
				throw new BizException("데이터 생성중 오류가 발생하였습니다.\n시스템 관리자에게 문의하세요.");
			}
			/* FMS_SO_PR_TEMP - > SO_PR	*/
			
			
			/* SO_PR - > GROUP BY RC_UPJANG,NEED_DATE	*/
			RecordSet glist = orderRequestUploadDAO.selectGroup(list.get(0));
			for (int i = 0; i < glist.size(); i++) {
				Map<String, Object> rowData = glist.get(i);
				String prNum = orderRequestUploadDAO.getprNum(rowData);//주문신청번호 생성  'B'+YYYYMMDD+SO_PR_NUM.NEXTVAL
				p_key_nm     = prNum;
				rowData.put("newPrNum", prNum);
				int upCnt = orderRequestUploadDAO.prNumUpdate(rowData);
				logger.debug("업데이트 건수  = " + upCnt);
				retProcVal = ifupdate(rowData,"C");
				if(!"S000".equals(retProcVal.get("O_RTN_CD").toString())){
					if(retProcVal.get("O_RTN_MSG") == null)retProcVal.put("O_RTN_MSG","("+rowData.get("subinvCode")+")"+"오류가 발생하였습니다.\n시스템 관리자에게 문의하세요.");
					throw new BizException("("+rowData.get("subinvCode")+")"+retProcVal.get("O_RTN_MSG").toString());
				}
				logger.debug("I/F CD  = " + retProcVal.get("O_RTN_MSG").toString());
				logger.debug("I/F MSG  = " + retProcVal.get("O_RTN_CD").toString());
				rowData.put("rtnMsg", retProcVal.get("O_RTN_MSG").toString());
				rowData.put("rtnCd", retProcVal.get("O_RTN_CD").toString());
				orderRequestUploadDAO.prNumUpdateIF(rowData);//구매 IF 결과 저장
				
				// 구매 프로시저 처리가 성공일 경우
				if ( ValidationUtil.isEquals(retProcVal.get("O_RTN_CD").toString(), Const.PURC_PROC_SUCC) ) {
					
					//발생전 금액 초기화
					p_occur_amt = 0;
					
					for ( int j = 0; j < list.size(); j++ ) {
						map = list.get(j);
						
						if (   ValidationUtil.isEquals(map.get("rcUpjang").toString(), rowData.get("rcUpjang").toString()) 
								&& ValidationUtil.isEquals(map.get("needDate").toString(), rowData.get("needDate").toString()) 
								) {
							sellAmt = Double.parseDouble(map.get("salePrice").toString()) * Double.parseDouble(map.get("prQty").toString());  
							// 과세일 경우
							if ( ValidationUtil.isEquals(map.get("taxCode").toString(), Const.TXN_CLSS_100) ) {
								p_occur_amt += Math.round(sellAmt * 1.1); 
							} else {
								p_occur_amt += Math.round(sellAmt);
							}
						}
					}
					
					Map<String, Object> rtnProcedure   = null;
					Map<String, Object> procedureParam = new HashMap<String, Object>();
					procedureParam.put("p_upjang_cd",        rowData.get("rcUpjang").toString());  // (필수)업장코드
					procedureParam.put("p_apply_date",       rowData.get("needDate").toString());  // (필수)적용일자(발주시:입고예정일 입금처리시: 입금일자 마감시:매출일자)
					procedureParam.put("p_occur_class",      "01");                                // (필수)발생구분(01:매입예정 02:매입확정 03:외상매출금)
					procedureParam.put("p_occur_amt",        p_occur_amt);                         // (필수)발생금액
					procedureParam.put("p_occur_amt_before", p_occur_amt_before);                  // (필수)발생금액(전)
					procedureParam.put("p_class_cd",         "01");                                // (필수)구분코드(01:주문신청관련 02:매출보정 03:판매단가변경 04:창고 강제변경 05:현지구매 06:영업회계 일마감 07:채권이관/입금처리)
					procedureParam.put("p_occur_table",      "SO_PR");                             // (필수)발생테이블
					procedureParam.put("p_key_nm",           "PR_NUM");                            // (필수)키명
					procedureParam.put("p_key_value01",      p_key_nm);                            // (필수)키1(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
					procedureParam.put("p_key_value02",      "");                                  // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
					procedureParam.put("p_key_value03",      "");                                  // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
					procedureParam.put("p_key_value04",      "");                                  // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
					procedureParam.put("p_key_value05",      "");                                  // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
					procedureParam.put("p_occur_prg_id",     "OrderRequest");                      // 프로그램ID
					procedureParam.put("p_occur_prg_nm",     "주문신청");                          // 프로그램 한글명
					procedureParam.put("p_cuser",            loginDTO.getSabun());                 // 생성자
					rtnProcedure = orderRequestDAO.procLncrTtz(procedureParam);
					
					if ( !ValidationUtil.isEquals(rtnProcedure.get("o_rtn").toString(), Const.YN_Y) ) {
						throw new BusinessRuntimeException(rtnProcedure.get("o_rtnmsg").toString());
					}
				}
			}
			
			/* SO_PR 등록 결과를 조회한다.	*/
			/*######*/
			rs = orderRequestUploadDAO.selectSopr(list.get(0));
			
			/* SO_PR에 등록된 모아담 리스트 업데이트*/
			upCnts2 = orderRequestUploadDAO.updateMoadam(listMap);
			/** 정상 종료시 TEMP 삭제.	**/
			orderRequestUploadDAO.tempDelfms(list.get(0));//구매 IF 결과 저장
			/** 정상 종료시 EXCEL TEMP 삭제.	**/
			orderRequestUploadDAO.tempDelExcel(list.get(0));//TEMP_BIZ_EXCEL 삭제
			
		}catch(Exception e){
			throw new BizException(e.getMessage());
		}
		
		return rs;
	}
// [속도개선 Project   끝] 2017. 8. 4. 최범주
	
	public RecordSet selectSISSubinvCode(Map<String, Object> mapParam) throws Exception {
		return orderRequestUploadDAO.selectSISSubinvCode(mapParam);	
	}

	public RecordSet selectSISItemCode(Map<String, Object> mapParam) throws Exception {
		return orderRequestUploadDAO.selectSISItemCode(mapParam);	
	}
	/**
	 * 구매 IF (row)
	 *
	 * @param Map ,String
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return Map
	 * @throws Exception
	*/
	public Map<String, Object> ifupdate(Map<String, Object> rowData, String gubun) throws Exception {
		/** 주문결의시 구매쪽 IF  **/
		Map<String, Object> pMap = new HashMap<String, Object>();
		pMap.put("i_sys_id", 	  String.valueOf("100")); //시스템 아이디
		pMap.put("i_comp_cd", 	  String.valueOf("HFC")); //회사 코드 ('HFC')
		pMap.put("i_req_sys_cd",  String.valueOf("FR")); //신청 시스템 코드 [PR: 전사구매, FR: 통합영업, WR: WMS]
		pMap.put("i_purc_typ_cd", String.valueOf("MT")); //신청 시스템 구매유형 코드[MT:식자재, CT:상품, BT:일반자재(소모품),ST:일반자재(저장품),JT:일반자재(고정자산)]
		pMap.put("i_shop_cd", 	  String.valueOf(rowData.get("rcUpjang"))); //신청업장 코드 - > 입고업장으로 변경
		pMap.put("i_req_usr_id",  String.valueOf(rowData.get("loginSabun"))); //신청자 아이디
		pMap.put("i_req_typ_cd",  String.valueOf(rowData.get("poType"))); //통합영업 S/O 유형코드(07)
		pMap.put("i_req_no", 	  String.valueOf(rowData.get("newPrNum"))); //Sales Order 요청 번호(PR_NUM)
		pMap.put("i_req_cls", 	  gubun); //요청 상태 [C-신규, U-수정, D-삭제]

		return orderRequestUploadDAO.sp_if_sales_order(pMap);
	}
	
	public String nvls(Object col) throws Exception{
		if(col == null)
			return "";
		else
			return StringUtil.null2string(col.toString(), "");
	}
	
	public double nvln(Object col) throws Exception{
		if(col == null)
			return 0;
		else
			return Double.parseDouble(col.toString());
	}

	
	/**
	 * 휴먼푸드 발주정보 업로드 권한을 조회한다.
	 * 추가일자:20211008  처리자:김혜진  
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectHumanAuth(Map<String, Object> mapParam) throws Exception {
		return orderRequestUploadDAO.selectHumanAuth(mapParam);
	}
	
	/**
	 * 모아담 업장리스트를 조회한다.
	 * 추가일자:20220630  처리자:김혜진  
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet searchMoadamUpjang(Map<String, Object> mapParam) throws Exception {
		return orderRequestUploadDAO.searchMoadamUpjang(mapParam);
	}
	
	/**
	 * 허브메카 id를 조회한다.
	 * 추가일자:20220701  처리자:김혜진  
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet searchHubId(Map<String, Object> mapParam) throws Exception {
		return orderRequestUploadDAO.searchHubId(mapParam);
	}
	
	/**
	 * 허브메카 id를 전체조회한다.
	 * 추가일자:20220712  처리자:김혜진  
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet searchHubIdAll(Map<String, Object> mapParam) throws Exception {
		return orderRequestUploadDAO.searchHubIdAll(mapParam);
	}
	
	/**
	 * 휴먼푸드 발주 내역을 조회한다.
	 * 추가일자:20211025  처리자:김혜진  
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectMoadamList(Map<String, Object> mapParam) throws Exception {
		return orderRequestUploadDAO.selectMoadamList(mapParam);
	}
	
	/**
	 * 허브메카 발주 내역을 조회한다.
	 * 추가일자:20211025  처리자:김혜진  
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectHubmekaList(Map<String, Object> mapParam) throws Exception {
		return orderRequestUploadDAO.selectHubmekaList(mapParam);
	}
	
	/**
	 * 허브메카 발주 내역(긴급)을 조회한다.
	 * 추가일자:20220906  처리자:김혜진  
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectHubmekaList29(Map<String, Object> mapParam) throws Exception {
		return orderRequestUploadDAO.selectHubmekaList29(mapParam);
	}
	/**
	 * Hubmeka 주문 엑셀업로드 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 구매유형 : 식자재_식재영업(FS) : 07 자료 기준 
	 * Hubmeka 주문 업로드
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public Map<String, List> saveListHubmeka(DataSetMap list,LoginDTO loginDTO) throws Exception {
		Map<String, List> rsMap = new HashMap<String, List>();
		List<Map<String, Object>> listSet = new ArrayList();
		List<Map<String, Object>> errorSet = new ArrayList(); 
		List<Map> listMap = new ArrayList<Map>();
		logger.debug("loginDTO : " + loginDTO);
		/*	엑셀 업로드시 PR_NUM 을 생성한다.	*/
		Map<String, Object> row = list.get(0);
		String prNum = orderRequestUploadDAO.excelPrNum(row);
		logger.debug("prNum : " + prNum);
		int inCnt = 0;
		int[] inCnts = null;
		/*	엑셀 리스트를 TEMP 테이블에 INSERT	*/
		for (int i = 0; i < list.size(); i++) {
			Map<String, Object> rowData = list.get(i);
			rowData.put("prNum", prNum);
			listMap.add(rowData);
		}
		if(listMap.size() == 0){
			throw new BizException("오류가 발생하였습니다. 재업로드 해주세요.\n(업로드할 데이터가 없습니다.)");
		}else{
			/*#######*/
			inCnts = orderRequestUploadDAO.tempHubmekaInsert(listMap);
		}
		
		String apNum = orderRequestDAO.selectApNum(row);
		row.put("approveNum", apNum);
		
		/*	엑셀 리스트와 INSERT 건수가 다르면 에러발생.	*/
		if(inCnts.length != list.size()){
			throw new BizException("오류가 발생하였습니다. 재업로드 해주세요.\n(저장한 데이터와 실데이터가 다름.)");
		}
		inCnt = orderRequestUploadDAO.tempUpdate(row);
		logger.debug("temp_update : " + inCnt);
		/*#######*/
		inCnt = orderRequestUploadDAO.insertMoadam(row); /*모아담과 동일*/
		logger.debug("fms_so_pr_temp insert : " + inCnt);
		
		logger.debug("##########");
		logger.debug("##########");
		
		row.put("prNum", prNum);
		
		/** 
		 * 	여신 체크 :  2015-11-30, 여신체크 단위를 본사, 본사통합여신 기준으로 체크
		 * 																**/
		// 여신체크 변수
		String headCreditYn = "";
		DecimalFormat df = new DecimalFormat("#,##0");
		
		List<Map> groupUpjang = orderRequestUploadDAO.upjangGroup(row);
		logger.debug("groupUpjang.size() : " + groupUpjang.size());
		
		for (int i = 0; i < groupUpjang.size(); i++) {
			Map<String, Object> rowData = groupUpjang.get(i);
			logger.debug("groupUpjang : " + groupUpjang.size() + "		:  " + i );
			
			headCreditYn = rowData.get("headCreditYn").toString();
			
// [속도개선 Project 시작] 2017. 8. 21. 최범주 여신정보조회 함수 대체
//			//=============================================
//			// 여신기준일자 CHECK  : 2015-12-24
//			//=============================================
//			RecordSet rsDate;
//			// 기준일자 SET
//			if(("Y").equals(rowData.get("headCreditYn")))
//				rsDate = orderRequestUploadDAO.selectNeedDate(rowData);
//			else
//				rsDate = orderRequestUploadDAO.selectNeedDate2(rowData);
//
//			if (rsDate.size() > 0)
//			{
//				Map map = rsDate.get(0);
//				// DEBUG --- 2
//				logger.debug(" 기준일자 변경 후");
//				logger.debug(" - needDate => " + map.get("needDate").toString());
//				
//				rowData.put("needDate", map.get("needDate").toString());
//			}
//			//=============================================
//			
//			
//			Map<String, Object> creInfo = orderRequestUploadDAO.selectCreInfo(rowData);
			Map<String, Object> inParam = new HashMap<String, Object>();
			inParam.put("schUpjang", rowData.get("rcUpjang").toString());
			inParam.put("schNeedDate", rowData.get("needDate").toString());
			Map<String, Object> creInfo = orderRequestDAO.selectCreInfo(inParam).get(0);
// [속도개선 Project   끝] 2017. 8. 21. 최범주
			// 본사통합여신 및 미통합 구분 체크
			// 여신체크여부(CREDIT_CONTROL_YN)에 대한 여부는 PASS, 여신관리 여부(필요 시 upjangGroup QUERY에 필드 추가 후 CHECK)
			if ("Y".equals(headCreditYn)) {
				logger.debug("=====본사통합여신=====");
				logger.debug(rowData.get("mainUpjang")+" : " + rowData.get("amt"));
				logger.debug(rowData.get("mainUpjang")+" : " + creInfo.get("creditAvailAmt"));
			} else {
				logger.debug("=====단일업장여신=====");
				logger.debug(rowData.get("rcUpjang")+" : " + rowData.get("amt"));
				logger.debug(rowData.get("rcUpjang")+" : " + creInfo.get("creditAvailAmt"));
			}
			if(Double.valueOf(rowData.get("amt").toString()) > Double.valueOf((creInfo.get("creditAvailAmt").toString()))){
				logger.debug("여신초과");
				// 여신초과 메시지
				String sMsg = "";
				sMsg = "(";
				sMsg = sMsg + "주문가능 : " + df.format(Double.valueOf(creInfo.get("creditAvailAmt").toString()));
				sMsg = sMsg + ", 판매금액 : " + df.format(Double.valueOf(rowData.get("amt").toString()));
				sMsg = sMsg + ")";
				
				rowData.put("amtRemark",  sMsg);
				logger.debug("여신초과 메시지 : " + rowData.get("amtRemark"));
				
				int upCnt = 0;
				if ("Y".equals(headCreditYn))
					// 본사통합여신 기준 업데이트
					upCnt = orderRequestUploadDAO.updateCreInfo2(rowData);
				else
					// 단일업장여신 기준 업데이트
					upCnt = orderRequestUploadDAO.updateCreInfo(rowData);
				logger.debug("Update : " + upCnt);
			}
		}
		
		
		logger.debug("### prNum : " + prNum);
		/*#######*/
		List<Map> temp = orderRequestUploadDAO.selectHubmeka(row);
		logger.debug("tempsize : " + temp.size());
		logger.debug("##########");
		logger.debug("##########");
		for (int i = 0; i < temp.size(); i++) {
			Map<String, Object> rowData = temp.get(i);
			if("N".equals(rowData.get("error").toString())){
				listSet.add(rowData);
			}else{
				errorSet.add(rowData);
			}
		}
		
		
		rsMap.put("dsList", listSet);
		rsMap.put("dsListError", errorSet);
		
		
		return rsMap;
	}
	
	
	/**
	 * Hubmeka 주문 엑셀업로드 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 구매유형 : 식자재_식재영업(FS)_긴급 : 29 자료 기준 
	 * Hubmeka 주문 업로드
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public Map<String, List> saveListHubmeka29(DataSetMap list,LoginDTO loginDTO) throws Exception {
		Map<String, List> rsMap = new HashMap<String, List>();
		List<Map<String, Object>> listSet = new ArrayList();
		List<Map<String, Object>> errorSet = new ArrayList(); 
		List<Map> listMap = new ArrayList<Map>();
		logger.debug("loginDTO : " + loginDTO);
		/*	엑셀 업로드시 PR_NUM 을 생성한다.	*/
		Map<String, Object> row = list.get(0);
		String prNum = orderRequestUploadDAO.excelPrNum(row);
		logger.debug("prNum : " + prNum);
		int inCnt = 0;
		int[] inCnts = null;
		/*	엑셀 리스트를 TEMP 테이블에 INSERT	*/
		for (int i = 0; i < list.size(); i++) {
			Map<String, Object> rowData = list.get(i);
			rowData.put("prNum", prNum);
			listMap.add(rowData);
		}
		if(listMap.size() == 0){
			throw new BizException("오류가 발생하였습니다. 재업로드 해주세요.\n(업로드할 데이터가 없습니다.)");
		}else{
			/*#######*/
			inCnts = orderRequestUploadDAO.tempHubmekaInsert(listMap);
		}
		
		String apNum = orderRequestDAO.selectApNum(row);
		row.put("approveNum", apNum);
		
		/*	엑셀 리스트와 INSERT 건수가 다르면 에러발생.	*/
		if(inCnts.length != list.size()){
			throw new BizException("오류가 발생하였습니다. 재업로드 해주세요.\n(저장한 데이터와 실데이터가 다름.)");
		}
		inCnt = orderRequestUploadDAO.tempUpdate(row);
		logger.debug("temp_update : " + inCnt);
		/*#######*/
		inCnt = orderRequestUploadDAO.insertMoadam29(row); /*모아담과 동일*/
		logger.debug("fms_so_pr_temp insert : " + inCnt);
		
		logger.debug("##########");
		logger.debug("##########");
		
		row.put("prNum", prNum);
		
		/** 
		 * 	여신 체크 :  2015-11-30, 여신체크 단위를 본사, 본사통합여신 기준으로 체크
		 * 																**/
		// 여신체크 변수
		String headCreditYn = "";
		DecimalFormat df = new DecimalFormat("#,##0");
		
		List<Map> groupUpjang = orderRequestUploadDAO.upjangGroup(row);
		logger.debug("groupUpjang.size() : " + groupUpjang.size());
		
		for (int i = 0; i < groupUpjang.size(); i++) {
			Map<String, Object> rowData = groupUpjang.get(i);
			logger.debug("groupUpjang : " + groupUpjang.size() + "		:  " + i );
			
			headCreditYn = rowData.get("headCreditYn").toString();
			
// [속도개선 Project 시작] 2017. 8. 21. 최범주 여신정보조회 함수 대체
//			//=============================================
//			// 여신기준일자 CHECK  : 2015-12-24
//			//=============================================
//			RecordSet rsDate;
//			// 기준일자 SET
//			if(("Y").equals(rowData.get("headCreditYn")))
//				rsDate = orderRequestUploadDAO.selectNeedDate(rowData);
//			else
//				rsDate = orderRequestUploadDAO.selectNeedDate2(rowData);
//
//			if (rsDate.size() > 0)
//			{
//				Map map = rsDate.get(0);
//				// DEBUG --- 2
//				logger.debug(" 기준일자 변경 후");
//				logger.debug(" - needDate => " + map.get("needDate").toString());
//				
//				rowData.put("needDate", map.get("needDate").toString());
//			}
//			//=============================================
//			
//			
//			Map<String, Object> creInfo = orderRequestUploadDAO.selectCreInfo(rowData);
			Map<String, Object> inParam = new HashMap<String, Object>();
			inParam.put("schUpjang", rowData.get("rcUpjang").toString());
			inParam.put("schNeedDate", rowData.get("needDate").toString());
			Map<String, Object> creInfo = orderRequestDAO.selectCreInfo(inParam).get(0);
// [속도개선 Project   끝] 2017. 8. 21. 최범주
			// 본사통합여신 및 미통합 구분 체크
			// 여신체크여부(CREDIT_CONTROL_YN)에 대한 여부는 PASS, 여신관리 여부(필요 시 upjangGroup QUERY에 필드 추가 후 CHECK)
			if ("Y".equals(headCreditYn)) {
				logger.debug("=====본사통합여신=====");
				logger.debug(rowData.get("mainUpjang")+" : " + rowData.get("amt"));
				logger.debug(rowData.get("mainUpjang")+" : " + creInfo.get("creditAvailAmt"));
			} else {
				logger.debug("=====단일업장여신=====");
				logger.debug(rowData.get("rcUpjang")+" : " + rowData.get("amt"));
				logger.debug(rowData.get("rcUpjang")+" : " + creInfo.get("creditAvailAmt"));
			}
			if(Double.valueOf(rowData.get("amt").toString()) > Double.valueOf((creInfo.get("creditAvailAmt").toString()))){
				logger.debug("여신초과");
				// 여신초과 메시지
				String sMsg = "";
				sMsg = "(";
				sMsg = sMsg + "주문가능 : " + df.format(Double.valueOf(creInfo.get("creditAvailAmt").toString()));
				sMsg = sMsg + ", 판매금액 : " + df.format(Double.valueOf(rowData.get("amt").toString()));
				sMsg = sMsg + ")";
				
				rowData.put("amtRemark",  sMsg);
				logger.debug("여신초과 메시지 : " + rowData.get("amtRemark"));
				
				int upCnt = 0;
				if ("Y".equals(headCreditYn))
					// 본사통합여신 기준 업데이트
					upCnt = orderRequestUploadDAO.updateCreInfo2(rowData);
				else
					// 단일업장여신 기준 업데이트
					upCnt = orderRequestUploadDAO.updateCreInfo(rowData);
				logger.debug("Update : " + upCnt);
			}
		}
		
		
		logger.debug("### prNum : " + prNum);
		/*#######*/
		List<Map> temp = orderRequestUploadDAO.selectHubmeka(row);
		logger.debug("tempsize : " + temp.size());
		logger.debug("##########");
		logger.debug("##########");
		for (int i = 0; i < temp.size(); i++) {
			Map<String, Object> rowData = temp.get(i);
			if("N".equals(rowData.get("error").toString())){
				listSet.add(rowData);
			}else{
				errorSet.add(rowData);
			}
		}
		
		
		rsMap.put("dsList", listSet);
		rsMap.put("dsListError", errorSet);
		
		
		return rsMap;
	}
	
	
	/**
	 * 허브메카 주문 엑셀업로드 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)
	 * 모아담 주문 업로드
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	 */
// [속도개선 Project 시작] 2017. 8. 4. 최범주 여신금액 집계 프로시저 추가
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public RecordSet saveHubmekaIfList(DataSetMap list, LoginDTO loginDTO) throws Exception {
		Map<String, Object> retProcVal = new HashMap<String, Object>();
		List<Map> listMap = new ArrayList<Map>();
		int inCnt = 0;
		int[] upCnts;
		int[] upCnts2;
		RecordSet rs = null;
		
		double p_occur_amt        = 0;
		double p_occur_amt_before = 0;
		String p_key_nm         = "";
		Map<String, Object> map = null;
		double sellAmt          = 0;
		
		try{
			/** 상위 그리드만 처리 하게 업데이트 **/
			for (int i = 0; i < list.size(); i++) {
				Map<String, Object> rowData = list.get(i);
				listMap.add(rowData);
			}
			/*######*/
			upCnts = orderRequestUploadDAO.update(listMap);
			logger.debug("upCnts : " + upCnts.length);
			/* FMS_SO_PR_TEMP - > SO_PR	*/
			/*######*/
			inCnt = orderRequestUploadDAO.insert2(list.get(0));
			logger.debug("Hubmeka Order insert!");
			logger.debug("LIST : " + list.size());
			logger.debug("listMap : " + listMap.size());
			logger.debug("SO_PR insert : " + inCnt);
			if(upCnts.length != inCnt){
				throw new BizException("데이터 생성중 오류가 발생하였습니다.\n시스템 관리자에게 문의하세요.");
			}
			/* FMS_SO_PR_TEMP - > SO_PR	*/
			
			
			/* SO_PR - > GROUP BY RC_UPJANG,NEED_DATE	*/
			RecordSet glist = orderRequestUploadDAO.selectGroup(list.get(0));
			for (int i = 0; i < glist.size(); i++) {
				Map<String, Object> rowData = glist.get(i);
				String prNum = orderRequestUploadDAO.getprNum(rowData);//주문신청번호 생성  'B'+YYYYMMDD+SO_PR_NUM.NEXTVAL
				p_key_nm     = prNum;
				rowData.put("newPrNum", prNum);
				int upCnt = orderRequestUploadDAO.prNumUpdate(rowData);
				logger.debug("업데이트 건수  = " + upCnt);
				retProcVal = ifupdate(rowData,"C");
				if(!"S000".equals(retProcVal.get("O_RTN_CD").toString())){
					if(retProcVal.get("O_RTN_MSG") == null)retProcVal.put("O_RTN_MSG","("+rowData.get("subinvCode")+")"+"오류가 발생하였습니다.\n시스템 관리자에게 문의하세요.");
					throw new BizException("("+rowData.get("subinvCode")+")"+retProcVal.get("O_RTN_MSG").toString());
				}
				logger.debug("I/F CD  = " + retProcVal.get("O_RTN_MSG").toString());
				logger.debug("I/F MSG  = " + retProcVal.get("O_RTN_CD").toString());
				rowData.put("rtnMsg", retProcVal.get("O_RTN_MSG").toString());
				rowData.put("rtnCd", retProcVal.get("O_RTN_CD").toString());
				orderRequestUploadDAO.prNumUpdateIF(rowData);//구매 IF 결과 저장
				
				// 구매 프로시저 처리가 성공일 경우
				if ( ValidationUtil.isEquals(retProcVal.get("O_RTN_CD").toString(), Const.PURC_PROC_SUCC) ) {
					
					//발생전 금액 초기화
					p_occur_amt = 0;
					
					for ( int j = 0; j < list.size(); j++ ) {
						map = list.get(j);
						
						if (   ValidationUtil.isEquals(map.get("rcUpjang").toString(), rowData.get("rcUpjang").toString()) 
								&& ValidationUtil.isEquals(map.get("needDate").toString(), rowData.get("needDate").toString()) 
								) {
							sellAmt = Double.parseDouble(map.get("salePrice").toString()) * Double.parseDouble(map.get("prQty").toString());  
							// 과세일 경우
							if ( ValidationUtil.isEquals(map.get("taxCode").toString(), Const.TXN_CLSS_100) ) {
								p_occur_amt += Math.round(sellAmt * 1.1); 
							} else {
								p_occur_amt += Math.round(sellAmt);
							}
						}
					}
					
					Map<String, Object> rtnProcedure   = null;
					Map<String, Object> procedureParam = new HashMap<String, Object>();
					procedureParam.put("p_upjang_cd",        rowData.get("rcUpjang").toString());  // (필수)업장코드
					procedureParam.put("p_apply_date",       rowData.get("needDate").toString());  // (필수)적용일자(발주시:입고예정일 입금처리시: 입금일자 마감시:매출일자)
					procedureParam.put("p_occur_class",      "01");                                // (필수)발생구분(01:매입예정 02:매입확정 03:외상매출금)
					procedureParam.put("p_occur_amt",        p_occur_amt);                         // (필수)발생금액
					procedureParam.put("p_occur_amt_before", p_occur_amt_before);                  // (필수)발생금액(전)
					procedureParam.put("p_class_cd",         "01");                                // (필수)구분코드(01:주문신청관련 02:매출보정 03:판매단가변경 04:창고 강제변경 05:현지구매 06:영업회계 일마감 07:채권이관/입금처리)
					procedureParam.put("p_occur_table",      "SO_PR");                             // (필수)발생테이블
					procedureParam.put("p_key_nm",           "PR_NUM");                            // (필수)키명
					procedureParam.put("p_key_value01",      p_key_nm);                            // (필수)키1(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
					procedureParam.put("p_key_value02",      "");                                  // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
					procedureParam.put("p_key_value03",      "");                                  // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
					procedureParam.put("p_key_value04",      "");                                  // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
					procedureParam.put("p_key_value05",      "");                                  // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
					procedureParam.put("p_occur_prg_id",     "OrderRequest");                      // 프로그램ID
					procedureParam.put("p_occur_prg_nm",     "주문신청");                          // 프로그램 한글명
					procedureParam.put("p_cuser",            loginDTO.getSabun());                 // 생성자
					rtnProcedure = orderRequestDAO.procLncrTtz(procedureParam);
					
					if ( !ValidationUtil.isEquals(rtnProcedure.get("o_rtn").toString(), Const.YN_Y) ) {
						throw new BusinessRuntimeException(rtnProcedure.get("o_rtnmsg").toString());
					}
				}
			}
			
			/* SO_PR 등록 결과를 조회한다.	*/
			/*######*/
			rs = orderRequestUploadDAO.selectSopr(list.get(0));
			
			/* SO_PR에 등록된 허브메카 리스트 업데이트*/
			upCnts2 = orderRequestUploadDAO.updateHubmeka(listMap);
			/** 정상 종료시 TEMP 삭제.	**/
			orderRequestUploadDAO.tempDelfms(list.get(0));//구매 IF 결과 저장
			/** 정상 종료시 EXCEL TEMP 삭제.	**/
			orderRequestUploadDAO.tempDelExcel(list.get(0));//TEMP_BIZ_EXCEL 삭제
			
		}catch(Exception e){
			throw new BizException(e.getMessage());
		}
		
		return rs;
	}
// [속도개선 Project   끝] 2017. 8. 4. 최범주
	
	/**
	 * 허브메카 발주정보 업로드 권한을 조회한다.
	 * 추가일자:20220615  처리자:김혜진  
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectHubAuth(Map<String, Object> mapParam) throws Exception {
		return orderRequestUploadDAO.selectHubAuth(mapParam);
	}
}
