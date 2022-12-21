package com.hwfs.sc.cmn.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.cmn.dao.SlipNumDAO;

 /**
 * 전표번호를 가져온다.
 * @ClassName SlipNumServiceImpl.java
 * @Description SlipNumServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 6. 18.  김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015. 6. 18.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/cmn/slipNumService")
public class SlipNumServiceImpl extends DefaultServiceImpl implements SlipNumService {

	/** SlipNumDAO */
    @Resource(name="/sc/cmn/slipNumDAO")
    private SlipNumDAO slipNumDAO;

    /**
	 * 전표번호를 반환한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @return
	 * @throws Exception
	 * @see com.hwfs.sc.cmn.service.SlipNumService#getSlipNumNewTx()
	*/
	@Override
	public String getSlipNumNewTx() throws Exception {
		// TODO Auto-generated method stub
		return slipNumDAO.getSlipNum();
	}
}
