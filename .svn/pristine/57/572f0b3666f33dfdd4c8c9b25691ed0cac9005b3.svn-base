package com.hwfs.fs.fsm.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fs.fsm.dao.MachineCodePopDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 코드를 조회하는 MachineCodePop Service Implementation
 * 
 * @ClassName MachineCodePopServiceImpl.java
 * @Description MachineCodePopServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.13    김예진        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김예진
 * @since 2015.03.13
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fs/fsm/machineCodePopService")
public class MachineCodePopServiceImpl extends DefaultServiceImpl implements MachineCodePopService {
	
	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** MachineCodePopDAO Bean 생성 */
	@Resource(name = "/fs/fsm/machineCodePopDAO")
	private MachineCodePopDAO machineCodePopDAO;
	

	/**
	 * 코드 목록을 조회한다.
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
	public RecordSet selectPopCodeList(Map<String, Object> mapParam) throws Exception {
		return machineCodePopDAO.selectPopCodeList(mapParam);
	}

}
