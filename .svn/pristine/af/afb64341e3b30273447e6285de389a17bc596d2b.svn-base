package com.hwfs.sc.scc.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.scc.dao.ParameterLogDAO;

 /**
 * 전송 Parameter에 대한 로그를 기록하는 ParameterLog Service Implementation
 * 
 * @ClassName ParameterLogServiceImpl.java
 * @Description ParameterLogServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.09.16    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.09.16
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/scc/parameterLogService")
public class ParameterLogServiceImpl extends DefaultServiceImpl implements ParameterLogService {
	
	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** ParameterLogDAO Bean 생성 */
	@Resource(name = "/sc/scc/parameterLogDAO")
	private ParameterLogDAO parameterLogDAO;
	

	/**
	 * 전송 Parameter에 대한 로그 목록을 조회한다.
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
		return parameterLogDAO.selectList(mapParam);
	}

	/**
	 * 전송 Parameter에 대한 로그 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int saveList(Map<String, Object> mapParam) throws Exception {
		int insRowCnt = 0;
		
		insRowCnt += parameterLogDAO.insert(mapParam);
				
		return insRowCnt;
	}
	
	public int setLog(String logKey, String logId, String logData) throws Exception {
		Map<String, Object> parameter = new HashMap<String, Object>();
		
		parameter.put("logKey", logKey);
		parameter.put("logId", logId);
		parameter.put("logData", logData);
		
		return saveList(parameter);
	}
	
	@SuppressWarnings("unchecked")
	public int setLog(String logKey, String logId, DataSetMap logData) throws Exception {
		Map<String, Object> parameter = new HashMap<String, Object>();
		StringBuffer sb = new StringBuffer();
		
		for (int i = 0 ; i < logData.size() ; i++) {
			Map<String, Object> rowData = logData.get(i);
			sb.append("ROW[ ");
			sb.append(String.valueOf(i));
			sb.append(" ] ");
			sb.append(rowData.toString());
		}
		
		parameter.put("logKey", logKey);
		parameter.put("logId", logId);
		parameter.put("logData", sb.toString());
		
		return saveList(parameter);
	}
}
