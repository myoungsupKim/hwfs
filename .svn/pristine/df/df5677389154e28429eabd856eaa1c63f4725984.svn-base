package com.hwfs.sc.cmn.service;

import hone.core.util.record.RecordSet;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.cmn.dao.OrgChoiceDAO;

/**
 * 조직정보를 조회한다.
 * 
 * @ClassName OrgChoiceServiceImpl.java
 * @Description OrgChoiceServiceImpl Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 3. 11.   김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015. 3. 11.
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/cmn/orgChoiceService")
public class OrgChoiceServiceImpl extends DefaultServiceImpl implements
		OrgChoiceService {
	@Resource(name = "/sc/cmn/orgChoiceDAO")
	private OrgChoiceDAO orgChoice;

	/**
	 * 조직정보를 조회한다.
	 * 
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 * 
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.sc.cmn.service.OrgChoiceService#selectList(java.util.Map)
	 */
	@Override
	public RecordSet selectList() throws Exception {
		return orgChoice.selectList();
	}

}
