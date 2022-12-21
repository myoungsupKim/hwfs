package com.hwfs.fm.fms.service;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.fm.fms.dao.ReturnOrderBySalesDAO;
import com.hwfs.fm.fms.dao.ReturnOrderListDAO;
import com.hwfs.sc.cmn.dto.LmsMmsDTO;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.cmn.service.LmsMmsSendService;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 발주현황하는 ReturnOrderList Service Implementation
 * 
 * @ClassName ReturnOrderListServiceImpl.java
 * @Description ReturnOrderListServiceImpl Class
 * @Modification-Information
* <pre>
*    수정일       수정자              수정내용
*  ----------   ----------   -------------------------------
*  2021.08.30   DEV02        최초생성
* </pre>
* @author [PJT]주문채널통합 : DEV02
* @since 2021.08.30
* @version 1.0
* @see 
* <pre>
*  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
* </pre>
*/
@Service("/fm/fms/returnOrderListService")
public class ReturnOrderListServiceImpl extends DefaultServiceImpl implements ReturnOrderListService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());
	
	/** ReturnOrderListDAO Bean 생성 */
	@Resource(name = "/fm/fms/returnOrderListDAO")
	private ReturnOrderListDAO returnOrderListDAO;
	
	/** ReturnOrderBySalesDAO Bean 생성 */
	@Resource(name = "/fm/fms/returnOrderBySalesDAO")
	private ReturnOrderBySalesDAO returnOrderBySalesDAO;
	
	/** LmsMmsSendService Bean 생성 */
	@Resource(name = "/sc/cmn/lmsMmsSendService")
	private LmsMmsSendService lmsMmsSendService;
	
	/**
	 * 발주현황 목록을 조회한다.
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
		return returnOrderListDAO.selectList(mapParam);
	}
	
	/**
	 * 발주현황 목록을 조회한다.
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
	public RecordSet selectSub(Map<String, Object> mapParam) throws Exception {
		if(mapParam.get("schOrderType2").equals("0")) {
			return returnOrderListDAO.selectSubOrder((mapParam));
		} else {
			return returnOrderListDAO.selectSub((mapParam));
		}
		
	}
	
	/**
	 * 발주현황 브랜드 확정 저장
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int saveConfirmList(DataSetMap list, LoginDTO loginDTO) throws Exception {
		int updRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			boolean isCheck = StringUtils.equals("1", (String)rowData.get("chk")); //chk가 1인 건만 처리함 (ui에서 CHECKBOX가 선택된 건)
			
			//Update 처리
			if (rowType == DataSet.ROW_TYPE_UPDATED && isCheck) {
				updRowCnt += returnOrderListDAO.updateConfirm(rowData);
			}
		}
		
		return updRowCnt;
	}
	
	/**
	 * 발주현황 브랜드 반려 저장
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int saveReturnList(DataSetMap list, LoginDTO loginDTO) throws Exception {
		int updRowCnt = 0;
		String sMsg = "[푸디스트]%s의 %s에 %s으로 주문한 %s 상품이 주문취소됐습니다.";
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			boolean isCheck = StringUtils.equals("1", (String)rowData.get("chk")); //chk가 1인 건만 처리함 (ui에서 CHECKBOX가 선택된 건)
			
			//Update 처리
			if (rowType == DataSet.ROW_TYPE_UPDATED && isCheck) {
				int iCheck = returnOrderListDAO.updateReturn(rowData);
				
				if(iCheck == 0){
					throw new BizException("주문내역 상태가 변경되었습니다.");
				}
				updRowCnt += iCheck;
				
				//LMS 전송 START
				Record rc =  returnOrderBySalesDAO.selectReturnOrderBySalesSmsInfo(rowData);
				if(rc != null){
					LmsMmsDTO lmsMmsDTO = new LmsMmsDTO();
					lmsMmsDTO.setPhone((String)rc.get("hpNo"));//수신자 전화번호
					lmsMmsDTO.setSubject("");//전송 제목
					lmsMmsDTO.setMsg(String.format(sMsg, (String)rc.get("upjangnmDisp"), (String)rc.get("needDate"), (String)rc.get("poTypeNm"), (String)rc.get("itemName")));//전송 메시지
					lmsMmsDTO.setCallback((String)rc.get("salesHp"));
					
					//전송할 시간 : 생략하면 현재 시간
					//lmsMmsDTO.setReqDate("20150501 1200");
					
					lmsMmsDTO.setTrDeptId(loginDTO.getDeptId());
					lmsMmsDTO.setTrCcId(loginDTO.getCcCd());
					lmsMmsDTO.setTrUserId(loginDTO.getSabun());
					lmsMmsDTO.setTrCustNo("");//테스트용이며, 업무에서는 수신자의 사업장코드로 설정한다.
					
					logger.debug(lmsMmsDTO.toString());
					lmsMmsSendService.saveLmsMms(lmsMmsDTO);
				}
				//LMS 전송 END
				
			}
		}
		
		return updRowCnt;
	}
}
