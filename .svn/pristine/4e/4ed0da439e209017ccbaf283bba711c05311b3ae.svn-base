package com.hwfs.rc.sle.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.sle.dao.BillListDAO;

 /**
 * BillListServiceImpl에 대한 설명 작성
 * @ClassName BillListServiceImpl.java
 * @Description BillListServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 5. 14.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 :외식영업(POS영업관리)
 * @since 2015. 5. 14.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/sle/billListService")
public class BillListServiceImpl extends DefaultServiceImpl implements BillListService {
	@Resource(name="/rc/sle/billListDAO")
	private BillListDAO billList;
	/**
	 * selectListGoods 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.BillListService#selectListGoods(java.util.Map)
	 */
	@Override
	public RecordSet selectListGoods(Map<String, Object> parameter) throws Exception {
		return billList.selectListGoods(parameter);
	}

	/**
	 * selectListPay 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.BillListService#selectListPay(java.util.Map)
	 */
	@Override
	public RecordSet selectListPay(Map<String, Object> parameter) throws Exception {
		return billList.selectListPay(parameter);
	}

	/**
	 * selectListPayGrp 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.BillListService#selectListPayGrp(java.util.Map)
	 */
	@Override
	public RecordSet selectListPayGrp(Map<String, Object> parameter) throws Exception {
		return billList.selectListPayGrp(parameter);
	}

	/**
	 * selectListBillInfo 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.BillListService#selectListBillInfo(java.util.Map)
	 */
	@Override
	public RecordSet selectListBillInfo(Map<String, Object> parameter) throws Exception {
		return billList.selectListBillInfo(parameter);
	}
	
	@Override
	public RecordSet selectListDiscont(Map<String, Object> parameter) throws Exception {
		return billList.selectListDiscont(parameter);
	}
	
	

	/**
	 * selectListTotal 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.BillListService#selectListTotal(java.util.Map)
	 */
	@Override
	public RecordSet selectListTotal(Map<String, Object> parameter) throws Exception {
		return billList.selectListTotal(parameter);
	}

}
