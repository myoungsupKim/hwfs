package com.hwfs.rc.sle.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.sle.dao.HotMenuRankOutletDAO;

 /**
 * SalsListMgmtServiceImpl에 대한 설명 작성
 * @ClassName SalsListMgmtServiceImpl.java
 * @Description SalsListMgmtServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 5. 12.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 :외식영업(POS영업관리)
 * @since 2015. 5. 12.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/sle/hotMenuRankOutletService")
public class HotMenuRankOutletServiceImpl extends DefaultServiceImpl implements HotMenuRankOutletService {
	@Resource(name="/rc/sle/hotMenuRankOutletDAO")
	private HotMenuRankOutletDAO hotMenuRankOutlet;
	 
	//업장 인기 상품
	@Override
	public RecordSet selectList(Map<String, Object> parameter) throws Exception {
		return hotMenuRankOutlet.selectList(parameter);
	}
}
