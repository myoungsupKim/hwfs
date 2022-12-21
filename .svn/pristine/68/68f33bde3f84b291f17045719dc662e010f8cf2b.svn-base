package com.hwfs.sm.spm.service;

import hone.core.util.record.RecordSet;
import java.util.Map;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sm.spm.dao.AdvanceTransferDAO;

 /**
 * 선수금 거래처 이관을하는 AdvanceTransfer Service Implementation
 * 
 * @ClassName AdvanceTransferServiceImpl.java
 * @Description AdvanceTransferServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.17    JUN        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.04.17
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sm/spm/advanceTransferService")
public class AdvanceTransferServiceImpl extends DefaultServiceImpl implements AdvanceTransferService {
	
	/** AdvanceTransferDAO Bean 생성 */
	@Resource(name = "/sm/spm/advanceTransferDAO")
	private AdvanceTransferDAO advanceTransferDAO;
	

	/**
	 * 선수금 거래처 이관 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return advanceTransferDAO.selectList(mapParam);
	}

}
