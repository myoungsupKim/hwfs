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
import com.hwfs.fm.fms.dao.ReturnOrderByCustDAO;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.sc.cmn.dto.LmsMmsDTO;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.cmn.service.LmsMmsSendService;
import com.tobesoft.xplatform.data.DataSet;
 
 /**
 * 반환발주 ReturnOrderByCust Service Implementation
 * 
 * @ClassName ReturnOrderByCustServiceImpl.java
 * @Description ReturnOrderByCustServiceImpl Class
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
@Service("/fm/fms/returnOrderByCustService")
public class ReturnOrderByCustServiceImpl extends DefaultServiceImpl implements ReturnOrderByCustService {
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());
	
	/** ReturnOrderByCustDAO Bean 생성 */
	@Resource(name = "/fm/fms/returnOrderByCustDAO")
	private ReturnOrderByCustDAO returnOrderByCustDAO;
	
	/** LmsMmsSendService Bean 생성 */
	@Resource(name = "/sc/cmn/lmsMmsSendService")
	private LmsMmsSendService lmsMmsSendService;
	
	/**
	 * 반환발주 조회
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectReturnOrderByCustList(Map<String, Object> mapParam) throws Exception {		
		return returnOrderByCustDAO.selectReturnOrderByCustList(mapParam);
	}

	/**
	 * 반환발주 정상주문일자(so_pr)조회
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectSoPrGetNeedDate(Map<String, Object> mapParam) throws Exception {
		return returnOrderByCustDAO.selectSoPrGetNeedDate(mapParam);
	}
	
	/**
	 * 반환발주 반환가능업장 확인
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectRtnOrderYn(Map<String, Object> mapParam) throws Exception {
		return returnOrderByCustDAO.selectRtnOrderYn(mapParam);
	}

	/**
	 * 반환발주를 Insert/Update 처리
	 * 
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public int saveReturnOrderByCustInfo(DataSetMap list, LoginDTO loginDTO) throws Exception {		
		int insRowCnt = 0;
		int updRowCnt = 0;	
		int delRowCnt = 0;
		int totCnt = 0;
		
		RecordSet rs = null;
		
		List<Map<String, Object>> sendList = new ArrayList<Map<String, Object>>();
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				
				Record r = returnOrderByCustDAO.selectPrNumChk(rowData);
				
				if ((!"N".equals(LimsUtil.checkNull(r.getString("prNum")))) && r.getInt("cnt") == 0) {
					rowData.put("prNum", r.getString("prNum"));
				} else {
					//신규채번
					Record r2 = returnOrderByCustDAO.selectGetPrNum(rowData);
					rowData.put("prNum", r2.getString("prNum"));
				}		
				
				Record r3 = returnOrderByCustDAO.selectGetPrId(rowData);
				rowData.put("prId", r3.getString("prId"));
				
				insRowCnt += returnOrderByCustDAO.insertReturnOrderByCustInfo(rowData);	
				
/* sms 발송관련 주석처리(Confluence 문자발송 → 반환·교환·증정 발주 취소 SMS발송과 마찬가지로 기능 테스트 이후 정상일 시 주석처리 (09. 09 종환대리 확인))
				//sms
				Record rc = returnOrderByCustDAO.selectReturnOrderByCustSmsInfo(rowData);
				if(rc != null){
					sendList.add(rc);
				}

				//영업사원 사번UPDATE(중복발송방지)
				returnOrderByCustDAO.updateWmsIntSabunInfo(rowData);
*/
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += returnOrderByCustDAO.updateReturnOrderByCustInfo(rowData);
			}
			//Delete 처리(update)				
			else if (rowType == DataSet.ROW_TYPE_DELETED) {				
				delRowCnt += returnOrderByCustDAO.deleteReturnOrderByCustInfo(rowData);
			}
			
		}
			
		// *********************
		// start send message
		// *********************
		if(sendList != null && sendList.size() > 0){
			//사업장명;UPJANGNM_DISP@FMS_UPJANG}에서 {입고일자;NEED_DATE@SO_PR_RTN}에 반환주문이 등록되었습니다.
			String sMsg = "%s에서 %s에 반환주문이 등록되었습니다.";
			String shpNo = "";
			for (int i = 0 ; i < sendList.size() ; i++) {
				Map<String, Object> sendMap = sendList.get(i);
//				String sItemNm = (String)sendMap.get("itemName");
//				if(sendList.size() > 1){
//					sItemNm += "(외 " + String.valueOf( sendList.size()-1) + "건)";
//				}
				
				LmsMmsDTO lmsMmsDTO = new LmsMmsDTO();
				lmsMmsDTO.setPhone((String)sendMap.get("salesHp"));//수신자 전화번호
				lmsMmsDTO.setSubject("");//전송 제목
				lmsMmsDTO.setMsg(String.format(sMsg, (String)sendMap.get("upjangnmDisp"), (String)sendMap.get("needDate")));//전송 메시지
				
				if( "".equals(LimsUtil.checkNull((String)sendMap.get("hpNo"))) ){
					shpNo = propertiesService.getString("ems.sms.callback.no", ""); //대표자번호
				}else{
					shpNo = (String)sendMap.get("hpNo");
				}
				
				lmsMmsDTO.setCallback(shpNo); //발신자
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
		// *********************
		// end send message
		// *********************
			
		return insRowCnt + updRowCnt + delRowCnt;
	}
	
}
