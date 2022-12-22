package com.hwfs.rc.bms.service;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.rc.bms.dao.EventMgmtDAO;
import com.hwfs.sc.cmn.service.AddrSearchService;
import com.hwfs.sc.cmn.service.AttachFileService;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * EventMgmtServiceImpl에 대한 설명 작성
 * @ClassName EventMgmtServiceImpl.java
 * @Description EventMgmtServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 6. 30.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 : 연회웨딩
 * @since 2015. 6. 30.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/bms/eventMgmtService")
public class EventMgmtServiceImpl extends DefaultServiceImpl implements EventMgmtService {

	@Resource(name="/rc/bms/eventMgmtDAO")
	private EventMgmtDAO eventMgmt;
	
	//주소를 처리하기 위한 공통 Service
	@Resource(name = "/sc/cmn/addrSearchService")
	private AddrSearchService addressService;
	
	
	/** AttachFile Service Bean 생성 */
	@Resource(name = "/sc/cmn/attachFileService")
	private AttachFileService attachFileService;
	
	//중복 예약 체크
	@Override
	public RecordSet reservDuplicationCheck(Map<String, Object> parameter) throws Exception {
		return eventMgmt.reservDuplicationCheck(parameter);
		 
	}
	
	
	//예약리스트 
	@Override
	public RecordSet reservList(Map<String, Object> parameter) throws Exception {
		return eventMgmt.reservList(parameter);
		 
	}
	
	//마스터
	@Override
	public RecordSet selectListMst(Map<String, Object> parameter) throws Exception {
		return eventMgmt.selectListMst(parameter);
		 
	}
	
	//Wedding
	@Override
	public RecordSet selectListWedding(Map<String, Object> parameter) throws Exception {
		return eventMgmt.selectListWedding(parameter);
		 
	}
	
	//객실내역
	@Override
	public RecordSet selectListRoom(Map<String, Object> parameter) throws Exception {
		return eventMgmt.selectListRoom(parameter);
		 
	}
	
	//상품
	@Override
	public RecordSet selectListGoods(Map<String, Object> parameter) throws Exception {
		parameter.put("fnbClass", "F").toString();
		return eventMgmt.selectListGoods(parameter);
		
	}
	
	//기타사항
	@Override
	public RecordSet selectListOther(Map<String, Object> parameter) throws Exception {
		parameter.put("fnbClass", "O").toString();
		return eventMgmt.selectListGoods(parameter);
		 
	}
	
	//외부발주품목
	@Override
	public RecordSet selectListOutSide(Map<String, Object> parameter) throws Exception {
		//parameter.set fnbClass
		parameter.put("fnbClass", "P").toString();
		return eventMgmt.selectListGoods(parameter);
		 
	}
	
	//연회장
	@Override
	public RecordSet selectListBanquet(Map<String, Object> parameter) throws Exception {
		parameter.put("fnbClass", "R").toString();
		return eventMgmt.selectListGoods(parameter);
		
	}
	
	//지불조건 검색
	@Override
	public RecordSet selectListPayment(Map<String, Object> parameter) throws Exception {
		return eventMgmt.selectListPayment(parameter);
		
	}
	
	@Override
	@SuppressWarnings("unchecked")
	public String saveData(DataSetMap  reservMst,   DataSetMap  reservBanquet, DataSetMap  reservGoods,   DataSetMap  reservRoom
			             , DataSetMap  reservOther, DataSetMap  reservOutside, DataSetMap  reservWedding, DataSetMap  reservFile
			             , String sabun) throws Exception {
		
		RecordSet dupRs;

		int seqGoods     = 0;  //일련번호
		int seqRoom      = 0;  //일련번호
		String reservNum = ""; //예약번호
		String strRefSeq = ""; //첨부참조일련번호

		//첨부파일 처리 : 업무별 저장소의 상대패스를 파라미터로 전달해야 한다.
		strRefSeq = attachFileService.save(reservFile, propertiesService.getString("rc.file.path") + "/bms", false);
		
		//기본정보
		for (int i = 0 ; i < reservMst.size() ; i++) {
			Map<String, Object> parameter = reservMst.get(i);
			int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			
			//주소 처리
			addressService.setAddress( parameter, "addrInfo", sabun);
			//파일번호 넣는다.
			parameter.put("fileKey", strRefSeq);	
			
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				
				//예약번호 없는 경우 신규 MAX 값을 생성 한다.
				if(!parameter.containsKey("reservNum") || "".equals(parameter.get("reservNum")))
				{					
					Record chkRs = eventMgmt.maxCodeCreateMst(parameter);
					if(chkRs != null && chkRs.size() > 0) {
						reservNum = chkRs.getString("maxCode");
						if(!"".equals(reservNum)){
							parameter.put("reservNum", reservNum);
						}
					}
				}
				eventMgmt.insertDataMst(parameter);
			}
			else if (rowType == DataSet.ROW_TYPE_UPDATED){
				
				eventMgmt.updateDataMst(parameter);
				
				reservNum = parameter.get("reservNum").toString();
				 
			}
			else 
			{
				eventMgmt.updateDataMst(parameter);
				reservNum = parameter.get("reservNum").toString();
			 
			}
			
		}
		
		//메뉴정보 저장 및 수정
		for (int i = 0 ; i < reservGoods.size() ; i++) {
			Map<String, Object> parameter = reservGoods.get(i);
			int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 

			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				
				//예약번호 없는 경우 신규 MAX 값을 생성 한다.
				if(!parameter.containsKey("reservNum") || "".equals(parameter.get("reservNum")))
				{					
					parameter.put("reservNum", reservNum);
				}
				
				//일련번호생성
				if(!parameter.containsKey("seq") || "".equals(parameter.get("seq")))
				{
					Record chkRs = eventMgmt.maxCodeCreateGoods(parameter);
					if(chkRs != null && chkRs.size() > 0) {
						seqGoods = chkRs.getInt("maxCode");
						if(!"".equals(seqGoods)){
							parameter.put("seq", seqGoods);
						}
					}
				}
				
				eventMgmt.insertDataGoods(parameter);
			}
			else if (rowType == DataSet.ROW_TYPE_UPDATED){
				eventMgmt.updateDataGoods(parameter);	 
			}
		}
		
		//객실예약 저장 및 수정
		for (int i = 0 ; i < reservRoom.size() ; i++) {
			Map<String, Object> parameter = reservRoom.get(i);
			int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 

			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				
				//예약번호 없는 경우 신규 MAX 값을 생성 한다.
				if(!parameter.containsKey("reservNum") || "".equals(parameter.get("reservNum")))
				{					
					parameter.put("reservNum", reservNum);
				}
				//일련번호생성
				if(!parameter.containsKey("seq") || "".equals(parameter.get("seq")))
				{
					Record chkRs = eventMgmt.maxCodeCreateRoom(parameter);
					if(chkRs != null && chkRs.size() > 0) {
						seqRoom = chkRs.getInt("maxCode");
						if(!"".equals(seqRoom)){
							parameter.put("seq", seqRoom);
						}
					}
				}
				
				eventMgmt.insertDataRoom(parameter);
			}
			else if (rowType == DataSet.ROW_TYPE_UPDATED){
				eventMgmt.updateDataRoom(parameter);	 
			}
		}
		
		
		//other 저장
		for (int i = 0 ; i < reservOther.size() ; i++) {
			Map<String, Object> parameter = reservOther.get(i);
			int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 

			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				
				//예약번호 없는 경우 신규 MAX 값을 생성 한다.
				if(!parameter.containsKey("reservNum") || "".equals(parameter.get("reservNum")))
				{					
					parameter.put("reservNum", reservNum);
				}
				//일련번호생성
				if(!parameter.containsKey("seq") || "".equals(parameter.get("seq")))
				{
					Record chkRs = eventMgmt.maxCodeCreateGoods(parameter);
					if(chkRs != null && chkRs.size() > 0) {
						seqGoods = chkRs.getInt("maxCode");
						if(!"".equals(seqGoods)){
							parameter.put("seq", seqGoods);
						}
					}
				}
				
				eventMgmt.insertDataGoods(parameter);
			}
			else if (rowType == DataSet.ROW_TYPE_UPDATED){
				eventMgmt.updateDataGoods(parameter);	 
			}
		}
		
		
		//OutSide 저장 
		for (int i = 0 ; i < reservOutside.size() ; i++) {
			Map<String, Object> parameter = reservOutside.get(i);
			int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 

			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				
				//예약번호 없는 경우 신규 MAX 값을 생성 한다.
				if(!parameter.containsKey("reservNum") || "".equals(parameter.get("reservNum")))
				{					
					parameter.put("reservNum", reservNum);
				}
				//일련번호생성
				if(!parameter.containsKey("seq") || "".equals(parameter.get("seq")))
				{
					Record chkRs = eventMgmt.maxCodeCreateGoods(parameter);
					if(chkRs != null && chkRs.size() > 0) {
						seqGoods = chkRs.getInt("maxCode");
						if(!"".equals(seqGoods)){
							parameter.put("seq", seqGoods);
						}
					}
				}
				
				eventMgmt.insertDataGoods(parameter);
			}
			else if (rowType == DataSet.ROW_TYPE_UPDATED){
				eventMgmt.updateDataGoods(parameter);	 
			}
		}
		
		//Wedding Save or Update
		for (int i = 0 ; i < reservWedding.size() ; i++) {
			Map<String, Object> parameter = reservWedding.get(i);
			int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			
			addressService.setAddress( parameter, "husbAddrInfo", sabun);
			addressService.setAddress( parameter, "brideAddrInfo", sabun);
			addressService.setAddress( parameter, "husbCompAddrInfo", sabun);
			addressService.setAddress( parameter, "brideCompAddrInfo", sabun);
			 
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				
				//예약번호 없는 경우 신규 MAX 값을 생성 한다.
				if(!parameter.containsKey("reservNum") || "".equals(parameter.get("reservNum")))
				{					
					parameter.put("reservNum", reservNum);
				}

				eventMgmt.insertDataWedding(parameter);
			}
			else if (rowType == DataSet.ROW_TYPE_UPDATED){
				eventMgmt.updateDataWedding(parameter);	 
			}
		}
		
		
		//Banqute 저장
		for (int i = 0 ; i < reservBanquet.size() ; i++) {
			Map<String, Object> parameter = reservBanquet.get(i);
			int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 

			//중복 검사 예약 또는 확정인 경우에만 검증 한다. 
			// 	 "1".equals(parameter.get("reservStatus")) ||  일단 제외 예약은 중복이 가능 하다.
			
			if ("2".equals(parameter.get("reservStatus"))) {
				
				dupRs = eventMgmt.reservDuplicationCheck(parameter);
				
				//중복 조건 체크
				if ((!dupRs.isEmpty() && dupRs.size() > 0) 
					 || (dupRs.size() == 1 && !dupRs.get(0).getString("reservNum").equals(parameter.get("reservNum")))) {

					String sMsg = "** 중복 예약 **"
								+ "\n 예약번호 : " + dupRs.get(0).getString("reservNum") + " (" + dupRs.get(0).getString("reservNm") + ")"
								+ "\n 예약일자 : " + dupRs.get(0).getString("reservDate") + " (" + dupRs.get(0).getString("reservTime") + ")"
								+ "\n 예약자명 : " + dupRs.get(0).getString("rsvnNm");
					throw new BizException(sMsg); 
				}
			}
			
			
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				
				//예약번호 없는 경우 신규 MAX 값을 생성 한다.
				if(!parameter.containsKey("reservNum") || "".equals(parameter.get("reservNum")))
				{					
					parameter.put("reservNum", reservNum);
				}
				//일련번호생성
				if(!parameter.containsKey("seq") || "".equals(parameter.get("seq")))
				{
					Record chkRs = eventMgmt.maxCodeCreateGoods(parameter);
					if(chkRs != null && chkRs.size() > 0) {
						seqGoods = chkRs.getInt("maxCode");
						if(!"".equals(seqGoods)){
							parameter.put("seq", seqGoods);
						}
					}
				}
				eventMgmt.insertDataGoods(parameter);
			}
			else if (rowType == DataSet.ROW_TYPE_UPDATED){
				eventMgmt.updateDataGoods(parameter);	 
			}
		}
		
		//이력 저장
		Map<String, Object> p = new HashMap<String, Object>();
		p.put("V_RESERV_NUM", reservNum);
		//Map<String, Object> Rtn = eventMgmt.reservLogSave(p);
		eventMgmt.reservLogSave(p);
		 
		return reservNum;
	}

	
	//선수금 처리
	//카드사결제 자료검색 최종것
	@Override
	public RecordSet selectListCardVan(Map<String, Object> parameter) throws Exception {
		return eventMgmt.selectListCardVan(parameter);
		
	}
	
	
	
	//지불조건 저장 카드인경우
	@Override
	@SuppressWarnings("unchecked")
	public int saveDataPayment(DataSetMap  payMst) {
		int procCnt = 0;
		int seqPay=0;  
		
		for (int i = 0 ; i < payMst.size() ; i++) {
			Map<String, Object> parameter = payMst.get(i);
			int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			 
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				
				//일련번호생성
				if(!parameter.containsKey("seq") || "".equals(parameter.get("seq")))
				{
					Record chkRs = eventMgmt.maxCodeCreatePayment(parameter);
					if(chkRs != null && chkRs.size() > 0) {
						seqPay = chkRs.getInt("maxSeq");
						if(!"".equals(seqPay)){
							parameter.put("seq", seqPay);
						}
					}
				}
				
				procCnt += eventMgmt.insertDataPayment(parameter);
			}
		}
 
		return  procCnt;
	}
	 
	//선수금 
	@Override
	public Map<String, Object> insertDataAdvanceIns(Map<String, Object> parameter) throws Exception {
		Map<String, Object> p = new HashMap<String, Object>();
		
		//
		
		p.put("P_SYS_CLASS",     "21");
		p.put("P_OCCUR_DATE",    parameter.get("salesDate"));
		p.put("P_UPJANG_CD",     parameter.get("outletCd"));
		p.put("P_RECEIPT_NUM",   parameter.get("reservNum"));
		
		p.put("P_POS_GUESTINFO", "");
		p.put("P_CUST_CD",       parameter.get("custCd"));
		p.put("P_CUST_NM",       parameter.get("custNm"));
		p.put("P_TEL_NUM",       "");
		p.put("P_REMARK",        "연회예약관리");
		
		p.put("P_AMT",           parameter.get("payAmt"));
		p.put("P_SUPPLY_AMT",    parameter.get("netAmt"));
		p.put("P_VAT_AMT",       parameter.get("vat"));
		
		if ("10".equals(parameter.get("payCd"))){
			p.put("P_SETTLE_CLASS",  "1");
		}else{
			p.put("P_SETTLE_CLASS",  "2");
		}
		
		p.put("P_ADVANCE_CLASS", "003");
		p.put("P_CUSER",         parameter.get("empNo")); 
		
		return eventMgmt.insertDataAdvanceIns(p);
	}
	
	//선수금 결제내역 
	@Override
	public Map<String, Object> insertDataAdvancePay(Map<String, Object> parameter) throws Exception {
		Map<String, Object> p = new HashMap<String, Object>();
		
	 
		p.put("P_SYS_CLASS",       "21");
		p.put("P_OCCUR_DATE",      parameter.get("salesDate"));
		p.put("P_UPJANG_CD",       parameter.get("outletCd"));
		p.put("P_RECEIPT_NUM",     parameter.get("reservNum"));
		
		if ("10".equals(parameter.get("payCd"))){
			p.put("P_SETTLE_CLASS",  "1");
		}else{
			p.put("P_SETTLE_CLASS",  "2");
		}
		
		p.put("P_SETTLE_REF_INFO", parameter.get("payDspl"));
		p.put("P_CUST_CD",         parameter.get("custCd"));
		p.put("P_CUST_NM",         parameter.get("custNm"));
		
		p.put("P_SETTLE_AMT",      parameter.get("payAmt"));
		p.put("P_ENC_SETTLE_INFO", parameter.get("payDspl"));
		p.put("P_APPRV_NUM",       parameter.get("apprvNum"));
		 
		p.put("P_CUSER",           parameter.get("empNo")); 
		
		return eventMgmt.insertDataAdvancePay(p);
	}
	 

	//선수금 취소
	@Override
	public Map<String, Object> insertDataAdvanceCancel(Map<String, Object> parameter) throws Exception {
		Map<String, Object> p = new HashMap<String, Object>();
		
	 
		p.put("P_SYS_CLASS",       "21");
		p.put("P_OCCUR_DATE",      parameter.get("salesDt"));
		p.put("P_UPJANG_CD",       parameter.get("outletCd"));
		p.put("P_RECEIPT_NUM",     parameter.get("reservNum"));
		
		p.put("P_USER",         parameter.get("empNo")); 
		
		return eventMgmt.insertDataAdvanceCancel(p);
	}
	
 
}
