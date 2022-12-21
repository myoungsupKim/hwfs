package com.hwfs.fm.fmo.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.cmn.util.RequestContextUtil;
import com.hwfs.fm.fmo.dao.CreditDetailViewDAO;
import com.hwfs.fm.fmo.dao.OrderRequestDAO;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 여신관련 상세정보를 조회하는 CreditDetailView Service Implementation
 * 
 * @ClassName CreditDetailViewServiceImpl.java
 * @Description CreditDetailViewServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.10.14    최성연        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최성연
 * @since 2015.10.14
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fm/fmo/creditDetailViewService")
public class CreditDetailViewServiceImpl extends DefaultServiceImpl implements CreditDetailViewService {
	
	/** CreditDetailViewDAO Bean 생성 */
	@Resource(name = "/fm/fmo/creditDetailViewDAO")
	private CreditDetailViewDAO creditDetailViewDAO;
	
	/** OrderRequestDAO Bean 생성 */
	@Resource(name = "/fm/fmo/orderRequestDAO")
	private OrderRequestDAO orderRequestDAO;

	/**
	 * 여신 상세정보를 조회 목록을 조회한다.
	 * <pre>
	 * - 업장별 여신기본정보 GET
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectUpjang(Map<String, Object> mapParam) throws Exception {
		return creditDetailViewDAO.selectUpjang(mapParam);
	}
	
	/**
	 * 여신 상세정보를 조회 목록을 조회한다.
	 * <pre>
	 * - 탭별 목록 조회
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		RecordSet rs;
		String sUpjangList = "";
		
		// 기준일자 SET
		if(("2").equals(mapParam.get("schGubun")))
			rs = orderRequestDAO.selectNeedDate(mapParam);
		else
			rs = orderRequestDAO.selectNeedDate2(mapParam);
		
		if (rs.size() > 0)
		{
			Map map = rs.get(0);
			mapParam.put("schNeedDate", map.get("needDate").toString());
		}
		
		// 업장리스트 구하기
		if(("2").equals(mapParam.get("schGubun"))) {
			rs = orderRequestDAO.selectCreUpjang(mapParam);
			
			for (int i = 0 ; i < rs.size() ; i++) {
				Map<String, Object> rowData = rs.get(i);
					sUpjangList += ", " + rowData.get("upjang").toString();
			}
			if (sUpjangList.equals(""))
				sUpjangList = "(NULL)";
			else
				sUpjangList = "(" + sUpjangList.substring(1) + ")";
				
			mapParam.put("sUpjangList", sUpjangList);
		}

		return creditDetailViewDAO.selectList(mapParam);
	}

	/**
	 * 여신 상세정보를 조회 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insRowCnt += creditDetailViewDAO.insert(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += creditDetailViewDAO.update(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += creditDetailViewDAO.delete(rowData);
			}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}

	/**
	 * 여신 상세정보를 보정 처리한다.
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
	public int saveCreditPro(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		
		// 업장정보만 있으면 되므로..
//		for (int i = 0 ; i < list.size() ; i++) {
		Map<String, Object> rowData = list.get(0);

		Map<String, Object> inParam = new HashMap<String, Object>();
		Map<String, Object> retVal = new HashMap<String, Object>();				
		String callProcName = "CREDIT_MODIFY_PRO";				
		
		inParam.put("P_UPJANG_CD", rowData.get("schUpjang"));
		inParam.put("P_WKGUBUN", rowData.get("schGubun")); // 1.단일업장, 2.메인업장
		inParam.put("P_WKUSER", RequestContextUtil.get("loginSabun"));
		
		retVal = creditDetailViewDAO.callProcedure(inParam, callProcName);

		// 프로시저 실패시 롤백
		if("FALSE".equals(retVal.get("O_RTN").toString())){
			throw new BizException(retVal.get("O_RTNMSG").toString());
		}

		insRowCnt ++;
//		}
				
		return insRowCnt;
	}
}
