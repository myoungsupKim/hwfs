package com.hwfs.sm.spm.service;

import hone.core.util.record.RecordSet;
import java.util.Map;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sm.spm.dao.AdvanceAlterPopDAO;

 /**
 * 선수금을 대체처리하는 AdvanceAlterPop Service Implementation
 * 
 * @ClassName AdvanceAlterPopServiceImpl.java
 * @Description AdvanceAlterPopServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.02    JUN        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.04.02
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sm/spm/advanceAlterPopService")
public class AdvanceAlterPopServiceImpl extends DefaultServiceImpl implements AdvanceAlterPopService {
	
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** AdvanceAlterPopDAO Bean 생성 */
	@Resource(name = "/sm/spm/advanceAlterPopDAO")
	private AdvanceAlterPopDAO advanceAlterPopDAO;
	
	/**
	 * 선수금 대체번호에 따른 선수금대체정보(조회조건)를 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet getAdvanceAltMst(Map<String, Object> mapParam) throws Exception {
		return advanceAlterPopDAO.getAdvanceAltMst(mapParam);
	}
	
	/**
	 * 선수금대체처리 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return advanceAlterPopDAO.selectList(mapParam);
	}

}
