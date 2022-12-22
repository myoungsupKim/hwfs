package com.hwfs.fm.fmo.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fm.fmo.dao.OrderReturnListDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 구매반려내역하는 OrderReturnList Service Implementation
 * 
 * @ClassName OrderReturnListServiceImpl.java
 * @Description OrderReturnListServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.08.10    최영준        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최영준
 * @since 2015.08.10
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fm/fmo/orderReturnListService")
public class OrderReturnListServiceImpl extends DefaultServiceImpl implements OrderReturnListService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());
	
	/** OrderReturnListDAO Bean 생성 */
	@Resource(name = "/fm/fmo/orderReturnListDAO")
	private OrderReturnListDAO orderReturnListDAO;
	

	/**
	 * 구매반려내역 목록을 조회한다.
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
		if(mapParam.get("schTabGubun").equals("0"))
		{
			return orderReturnListDAO.selectListRe(mapParam);
		}
		else if(mapParam.get("schTabGubun").equals("1"))
		{
			return orderReturnListDAO.selectListChg(mapParam);
		}
		else
		{
			return orderReturnListDAO.selectListItem(mapParam);
		}
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
