package com.hwfs.fs.fsl.dao;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 식권자판기 인터페이스용  DAO 개체
 * @ClassName FslIfVendingDAO.java
 * @Description FslIfVendingDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 8. 24.   이지운        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015. 7. 30.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fs/fsl/fslIfVendingDAO")
public class FslIfVendingDAO extends DefaultDAO {
	
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsl.fslIfVendingDAO.insert", mapParam);
	}
	
	public int upjang(Map<String, Object> mapParam) throws Exception {
		return super.queryForInt("fs.fsl.fslIfVendingDAO.upjang", mapParam);
	}
	
	public int cust(Map<String, Object> mapParam) throws Exception {
		return super.queryForInt("fs.fsl.fslIfVendingDAO.custcd", mapParam);
	}

}
