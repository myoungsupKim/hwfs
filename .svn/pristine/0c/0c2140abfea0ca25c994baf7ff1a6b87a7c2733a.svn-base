package com.hwfs.fm.fmo.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.sql.Types;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fm.fmo.dao.OrderRequestConfirmDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 주문확정하는 OrderRequestConfirm Service Implementation
 * 
 * @ClassName OrderRequestConfirmServiceImpl.java
 * @Description OrderRequestConfirmServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.25    손형민        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 손형민
 * @since 2015.06.25
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fm/fmo/orderRequestConfirmService")
public class OrderRequestConfirmServiceImpl extends DefaultServiceImpl implements OrderRequestConfirmService {

	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());
	
	/** OrderRequestConfirmDAO Bean 생성 */
	@Resource(name = "/fm/fmo/orderRequestConfirmDAO")
	private OrderRequestConfirmDAO orderRequestConfirmDAO;
	

	/**
	 * 주문확정 목록을 조회한다.
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
		// CENTER_CODE 다중 처리 : 2016-01-11
		mapParam.put("schCode", inCode(mapParam.get("schCode").toString()));
		return orderRequestConfirmDAO.selectList(mapParam);
	}

	/**
	 * 주문확정 상세 목록을 조회한다.
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
		// CENTER_CODE 다중 처리 : 2016-01-11
		mapParam.put("schCode", inCode(mapParam.get("schCode").toString()));
		return orderRequestConfirmDAO.selectSub(mapParam);
	}
	
	/**
	 * 주문확정 확정전 [통제여부]를 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectSubFlag(Map<String, Object> mapParam) throws Exception {
		if("0".equals(mapParam.get("schSearchGubun").toString())){
			mapParam.put("schSubCusts", inCode(mapParam.get("schSubCusts").toString()));
		}else if("1".equals(mapParam.get("schSearchGubun").toString())){
			mapParam.put("schSubUpjangs", inCode(mapParam.get("schSubUpjangs").toString()));
		}
		RecordSet rsList = orderRequestConfirmDAO.poNumList(mapParam);
		String poNums = "";
		for (int i = 0 ; i < rsList.size() ; i++) {
			poNums += rsList.get(i).get("poNum") + ",";
		}
		mapParam.put("schPoNums", inCode(poNums.substring(0, poNums.length()-1)));
		return orderRequestConfirmDAO.selectSubFlag(mapParam);
	}

	/**
	 * 주문확정 DataSetMap의 데이터를 확정 처리한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public Map<String, Object> saveList(DataSetMap list) throws Exception {
		Map<String, Object> retProcItemVal = new HashMap<String, Object>();
		int insRowCnt = 0;
		int updRowCnt = 0;
		
		int delRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			if(rowData.get("chk").toString().equals("1")){
				int updCnt = 0;
				updCnt += orderRequestConfirmDAO.update(rowData);
				updRowCnt += updCnt;
			}
		}
		return retProcItemVal;
	}
	
	/**
	 * 주문확정 DataSetMap의 데이터를 취소 처리한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int cnclList(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			
			if(rowData.get("chk").toString().equals("1")){
				updRowCnt += orderRequestConfirmDAO.cnclupdate005(rowData);
			}
		}
		return insRowCnt + updRowCnt + delRowCnt;
	}
	
	/**
	 * 콤마 값을 IN 처리에 맞게 변경.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	public String inCode(String schCode) throws Exception {
		
		if(schCode.indexOf(',') != -1){
			return "'"+schCode.replaceAll(",", "','")+"'";
		}else{
			return "'"+schCode+"'";
		}
	}
	
}
