package com.hwfs.sc.cmn.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.cmn.dao.SendCreditInfoDAO;

/**
 * SendCreditInfoServiceImp에 대한 설명 작성
 * 
 * @ClassName SendCreditInfoServiceImp.java
 * @Description SendCreditInfoServiceImp Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2016. 12. 2.   901X5L        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 901X5L
 * @since 2016. 12. 2.
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/cmn/sendCreditInfoService")
public class SendCreditInfoServiceImp extends DefaultServiceImpl implements SendCreditInfoService {
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	@Resource(name = "/sc/cmn/sendCreditInfoDAO")
	private SendCreditInfoDAO sendCreditInfoDAO;

	@Override
	public RecordSet selectPartSalesList(Map<String, Object> parameter) throws Exception {
		return sendCreditInfoDAO.selectPartSalesList(parameter);
	}

	@Override
	public RecordSet selectCreditInfo(Map<String, Object> parameter) throws Exception {
		return sendCreditInfoDAO.selectCreditInfo(parameter);
	}

}
