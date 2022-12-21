package com.hwfs.rc.sle.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.sle.dao.ResvInqDAO;

 /**
 * ResvInqServiceImpl에 대한 설명 작성
 * @ClassName ResvInqServiceImpl.java
 * @Description ResvInqServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 5. 8.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 :외식영업(POS영업관리)
 * @since 2015. 5. 8.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/sle/resvInqService")
public class ResvInqServiceImpl extends DefaultServiceImpl implements ResvInqService {
	@Resource(name="/rc/sle/resvInqDAO")
	private ResvInqDAO resvInq;
	/**
	 * selectList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.ResvInqService#selectList(java.util.Map)
	 */
	@Override
	public RecordSet selectList(Map<String, Object> parameter) throws Exception {
		return resvInq.selectList(parameter);
	}

	/**
	 * selectListMst 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.ResvInqService#selectListMst(java.util.Map)
	 */
	@Override
	public RecordSet selectListMst(Map<String, Object> parameter) throws Exception {
		return resvInq.selectListMst(parameter);
	}

	/**
	 * selectListGoods 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.ResvInqService#selectListGoods(java.util.Map)
	 */
	@Override
	public RecordSet selectListGoods(Map<String, Object> parameter) throws Exception {
		return resvInq.selectListGoods(parameter);
	}

}
