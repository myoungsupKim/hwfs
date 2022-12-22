package com.hwfs.fm.fms.service;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.fm.fms.dao.ReturnOrderBySalesDAO;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.sc.cmn.dto.LmsMmsDTO;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.cmn.service.LmsMmsSendService;
import com.tobesoft.xplatform.data.DataSet;
 
 /**
 * 반환/교환/증정발주 ReturnOrderBySales Service Implementation
 * 
 * @ClassName ReturnOrderBySalesServiceImpl.java
 * @Description ReturnOrderBySalesServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2021.07.21    Jaey        최초생성
 *  
 * </pre>
 * @author Jaey
 * @since 2021.07.21
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fm/fms/returnOrderBySalesService")
public class ReturnOrderBySalesServiceImpl extends DefaultServiceImpl implements ReturnOrderBySalesService {
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());
	
	/** ReturnOrderBySalesDAO Bean 생성 */
	@Resource(name = "/fm/fms/returnOrderBySalesDAO")
	private ReturnOrderBySalesDAO returnOrderBySalesDAO;
	
	/** LmsMmsSendService Bean 생성 */
	@Resource(name = "/sc/cmn/lmsMmsSendService")
	private LmsMmsSendService lmsMmsSendService;
	
	/**
	 * 반환/교환/증정발주 조회
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectReturnOrderBySalesList(Map<String, Object> mapParam) throws Exception {
		return returnOrderBySalesDAO.selectReturnOrderBySalesList(mapParam);
	}

	/**
	 * 반환 주문유형의 주문일자 선택시 정상주문 유형여부 확인 조회
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectRtnOrderYn(Map<String, Object> mapParam) throws Exception {
		return returnOrderBySalesDAO.selectRtnOrderYn(mapParam);
	}

	/**
	 * 반환/교환/증정발주를 Insert/Update 처리
	 * 
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public int saveReturnOrderBySalesInfo(DataSetMap list, LoginDTO loginDTO) throws Exception {		
		int insRowCnt = 0;
		int updRowCnt = 0;	
		int delRowCnt = 0;
		int totCnt = 0;
		String prNum = "";
		
		RecordSet rs = null;
		
		List<Map<String, Object>> sendList = new ArrayList<Map<String, Object>>();
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				
				Record r = returnOrderBySalesDAO.selectPrNumChk(rowData);
				
				if ((!"N".equals(LimsUtil.checkNull(r.getString("prNum")))) && r.getInt("cnt") == 0) {
					rowData.put("prNum", r.getString("prNum"));
					prNum = (String)r.getString("prNum");
				} else {
					//신규채번
					Record r2 = returnOrderBySalesDAO.selectGetPrNum(rowData);
					rowData.put("prNum", r2.getString("prNum"));
					prNum = (String)r2.getString("prNum");
				}		
				
				Record r3 = returnOrderBySalesDAO.selectGetPrId(rowData);
				rowData.put("prId", r3.getString("prId"));
				
				insRowCnt += returnOrderBySalesDAO.insertReturnOrderBySalesInfo(rowData);					
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += returnOrderBySalesDAO.updateReturnOrderBySalesInfo(rowData);
				prNum = (String)rowData.get("prNum");
			}
			//Delete 처리(update)				
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				/*
				if("tab1".equals(rowData.get("tabName"))){//반환의 경우 SMS목록  ADD					
					Record rc = returnOrderBySalesDAO.selectReturnOrderBySalesSmsInfo(rowData);
					if(rc != null){
						sendList.add(rc);
					}					
				}
				*/
				delRowCnt += returnOrderBySalesDAO.deleteReturnOrderBySalesInfo(rowData);
			}
			
			totCnt = insRowCnt + updRowCnt;
			if (totCnt > 0){
				/**
				 * //##주석 : 반환가능품목등록에 등록된 상품만 조회라서 체크로직을 제외했지만 (2021.09.02)등록되지않은 상품도 조회로 변경이 되었으므로 반환역시 체크로직을 태운다...
				 * */
				//if(!"tab1".equals(rowData.get("tabName"))){//반환아닌경우		//##
					//추가 또는 수정시 PR_ID 및 ROW_TYPE값을 임시 테이블에 저장한다.
		            //구매 자재신청 유효성 체크시 해당 동일 PR_NUM중에서 해당 테이블에 있는 PR_ID신청 및 수정건만 체크하기 위함
					if (rowType == DataSet.ROW_TYPE_INSERTED) 
					{
						rowData.put("rowType", "I");
						returnOrderBySalesDAO.insertFmpPrIdTemp(rowData);
					}
					else if (rowType == DataSet.ROW_TYPE_UPDATED)
					{
						rowData.put("rowType", "U");
						returnOrderBySalesDAO.insertFmpPrIdTemp(rowData);
					}
				//}		//##
			}
		}
		
		if(list.size() > 0){
			String rtnVal = "";
			Map<String, Object> chkRowData = list.get(0);
			chkRowData.put("prNum", prNum);	
			//교환/증정만..
			if((!(LimsUtil.checkNull(chkRowData.get("rcUpjang")).equals("")) && !"tab1".equals(chkRowData.get("tabName"))))	//##			
//			if( (!(LimsUtil.checkNull(chkRowData.get("rcUpjang")).equals(""))) )
			{	
				// 수발주 스케쥴에 따른 유효성 체크
				rs = returnOrderBySalesDAO.selectReturnOrderBySalesCheck1(chkRowData);					
				if(! rs.isEmpty() ){
					for (int i = 0 ; i < rs.size() ; i++) {
						if(i == 0){
							rtnVal += "1ITEM_CODE="+rs.get(i).get("itemCode")+"@$@"
									+ "ITEM_NAME="+rs.get(i).get("itemName")+"@$@"
									+ "ITEM_VAL="+rs.get(i).get("itemVal");
						}else{
							rtnVal += "@#@"+"ITEM_CODE="+rs.get(i).get("itemCode")
									+ "@$@"+"ITEM_NAME="+rs.get(i).get("itemName")
									+ "@$@"+"ITEM_VAL="+rs.get(i).get("itemVal");
						}
					}
					throw new BizException(rtnVal);
				}
				
				// 구매 자재신청 유효성 체크
				rs = returnOrderBySalesDAO.selectReturnOrderBySalesCheck2(chkRowData);
				if(! rs.isEmpty() ){
					for (int i = 0 ; i < rs.size() ; i++) {
						if(i == 0){
							rtnVal += "2ITEM_CODE="+rs.get(i).get("itemCode")+"@$@"
									+ "ITEM_NAME="+rs.get(i).get("itemName")+"@$@"
									+ "ITEM_VAL="+rs.get(i).get("itemVal");
						}else{
							rtnVal += "@#@"+"ITEM_CODE="+rs.get(i).get("itemCode")
									+ "@$@"+"ITEM_NAME="+rs.get(i).get("itemName")
									+ "@$@"+"ITEM_VAL="+rs.get(i).get("itemVal");
						}
					}
					throw new BizException(rtnVal);
				}
				
			}
			
			//if(!"tab1".equals(chkRowData.get("tabName"))){//반환아닌경우 		//##
				//임시삭제
				returnOrderBySalesDAO.deleteFmpPrIdTemp(chkRowData);
			//}		//##
		}
			
		// *********************
		// start send message
		// *********************
		Map<String, List<Map<String, Object>>> sendItemGroup = new HashMap<String, List<Map<String, Object>>>();
		if(sendList != null && sendList.size()> 0){
			
			// 발송정보 grouping
			for(Map<String, Object> sendMap : sendList){
				String sHpNo = (String)sendMap.get("hpNo");
				List<Map<String, Object>> itemList = null;
				
				if(sendItemGroup.containsKey(sHpNo)){
					itemList = sendItemGroup.get(sHpNo);
				} else {
					itemList = new ArrayList<Map<String, Object>>();
				}
				itemList.add(sendMap);
				sendItemGroup.put(sHpNo, itemList);
			}
			
			//[푸디스트]{발주사업장명}의 {YYYY-MM-DD}에 {PO_TYPE명}으로 주문한 {ITEM_NAME}(외 n건) 상품이 주문취소됐습니다.
			String sMsg = "[푸디스트]%s의 %s에 %s으로 주문한 %s 상품이 주문취소됐습니다.";
			Iterator<String> keys = sendItemGroup.keySet().iterator();
			while (keys.hasNext()) {
				String sHpNo = keys.next();
				List<Map<String, Object>> itemList = sendItemGroup.get(sHpNo);
			
				if(itemList != null && itemList.size() > 0){
					Map<String, Object> sendMap = itemList.get(0);
					String sItemNm = (String)sendMap.get("itemName");
					if(itemList.size() > 1){
						sItemNm += "(외 " + String.valueOf( itemList.size()-1) + "건)";
					}
					
					LmsMmsDTO lmsMmsDTO = new LmsMmsDTO();
					lmsMmsDTO.setPhone(sHpNo);//수신자 전화번호
					lmsMmsDTO.setSubject("");//전송 제목
					lmsMmsDTO.setMsg(String.format(sMsg, (String)sendMap.get("upjangnmDisp"), (String)sendMap.get("needDate"), (String)sendMap.get("poTypeNm"), sItemNm));//전송 메시지
					lmsMmsDTO.setCallback((String)sendMap.get("salesHp"));
					
					//전송할 시간 : 생략하면 현재 시간
					//lmsMmsDTO.setReqDate("20150501 1200");
					
					lmsMmsDTO.setTrDeptId(loginDTO.getDeptId());
					lmsMmsDTO.setTrCcId(loginDTO.getCcCd());
					lmsMmsDTO.setTrUserId(loginDTO.getSabun());
					lmsMmsDTO.setTrCustNo("");//테스트용이며, 업무에서는 수신자의 사업장코드로 설정한다.
					
					//logger.debug(lmsMmsDTO.toString());
					lmsMmsSendService.saveLmsMms(lmsMmsDTO);
				}
			}
		}
		// *********************
		// end send message
		// *********************
			
		return insRowCnt + updRowCnt + delRowCnt;
	}
	
}
