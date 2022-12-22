package com.hwfs.sm.sar.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.batch.core.ExitStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.sm.sar.service.ReceiveMgntService;
import com.hwfs.sm.sar.dao.ReceiveMgntDAO;


 /**
 * 입금관리하는 ReceiveMgnt Controller
 * 
 * @ClassName ReceiveMgntController.java
 * @Description ReceiveMgntController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.16    김명호        최초생성
 * </pre>
 * @author FC종합전산구축 :  통합영업 김명호
 * @since 2015.04.16
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/sm/sar/receiveMgnt/")
public class ReceiveMgntController extends DefaultController {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** ReceiveMgntService Bean 생성 */
	@Resource(name = "/sm/sar/receiveMgntService")
	private ReceiveMgntService receiveMgntService;
	
	/** ReceiveMgntDAO Bean 생성 */
	@Resource(name = "/sm/sar/receiveMgntDAO")
	private ReceiveMgntDAO receiveMgntDAO;
	
	/**
	 * 입금관리 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectList.xdo")
	public ModelAndView selectList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Variable Parameter을 추출한다.
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
		
		//입금관리 을(를) 조회한다.
		RecordSet rs = receiveMgntService.selectList(parameter.get("ds_search").get(0));

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 상계처리 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectBTList01.xdo")
	public ModelAndView selectBTList01(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Variable Parameter을 추출한다.
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
		
		//입금관리 을(를) 조회한다.
		RecordSet rs = receiveMgntService.selectBTList01(parameter.get("ds_search").get(0));

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 플러스채권 대체처리 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectBTList02.xdo")
	public ModelAndView selectBTList02(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Variable Parameter을 추출한다.
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
		
		//입금관리 을(를) 조회한다.
		RecordSet rs = receiveMgntService.selectBTList02(parameter.get("ds_search").get(0));

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 입금관리 상세 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectDetailList.xdo")
	public ModelAndView selectDetailList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Variable Parameter을 추출한다.
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
		
		//입금관리상세 을(를) 조회한다.
		RecordSet rs1 = receiveMgntService.selectDetailList1(parameter.get("ds_search").get(0));
		RecordSet rs2 = receiveMgntService.selectDetailList2(parameter.get("ds_search").get(0));
		RecordSet rs3 = receiveMgntService.selectDetailList3(parameter.get("ds_search").get(0));

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list1", rs1);
		super.addOutDataSet(mav, "ds_list2", rs2);
		super.addOutDataSet(mav, "ds_list3", rs3);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 입금관리(을)를 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("saveList.xdo")
	public ModelAndView saveList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_list");

		//입금관리을(를) 등록, 수정, 삭제 처리한다.
		int processCnt = receiveMgntService.saveList(parameter);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	
	/**
	 * 마이너스 상계(을)를 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("batchProc.xdo")
	public ModelAndView batchProc(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_search");
			
		Map<String, Object> rowData = parameter.get(0);
		
		String tm_cd = rowData.get("tmCd").toString();
		
	    Map<String, Object> retProcVal = new HashMap<String, Object>();

        /*
        P_MONTH             IN  VARCHAR2,     --기준월
        P_TM_CD               IN  VARCHAR2,   --팀(본부)
        P_CC_CD               IN  VARCHAR2,   --CC
        P_CUST_CD             IN  VARCHAR2,   --거래처
        */
        Map<String, Object> procParam = new HashMap<String, Object>();
        //logger.debug("P_MONTH : " + rowData.get("month"));      
        //logger.debug("P_TM_CD : " + "[" + tm_cd + "]");          
        procParam.put("P_MONTH", rowData.get("month"));
        //월마감 확인
		RecordSet rs = receiveMgntService.chkClose(param.get("ds_search").get(0));
        int tCnt = Integer.parseInt(rs.get(0).get("tCnt").toString());
        logger.debug("tCnt : " + "[" + tCnt + "]");        
		//영업&회계 월마감 된건이 0인 경우만 실행
		//if (rs.get(0).get("tCnt").equals("0")) {
		if (tCnt == 0) {
	        
	        //if (!LimsUtil.checkNull(tm_cd).equals("TRUE")) {
	        if (!tm_cd.equals("")) {
	        	//팀코드 있는 경우
	        	procParam.put("P_TM_CD", rowData.get("tmCd"));
	        	procParam.put("P_CC_CD", rowData.get("ccCd"));
	        	procParam.put("P_CUST_CD", rowData.get("custCd"));   
	        	procParam.put("P_USER", "SYSTEM-ST1");         
	        	
	            retProcVal = receiveMgntDAO.batchst1Pro(procParam);   	
	        } else {
	        	//팀코드 없는 경우
	        	procParam.put("P_TM_CD", rowData.get("tmCd"));
	        	procParam.put("P_CC_CD", rowData.get("ccCd"));    
	        	procParam.put("P_CUST_CD", rowData.get("custCd"));    
	        	procParam.put("P_USER", "SYSTEM-ST1");           	
	        	
	            retProcVal = receiveMgntDAO.batchst1aPro(procParam);
	        }
	        
	        // 로그를 쌓는다.
	        String strRtnMsg = "";   
	        logger.debug("O_RTN : " + retProcVal.get("O_RTN"));             
	        logger.debug("O_RTNMSG : " + retProcVal.get("O_MESSAGE"));          
	        if (!LimsUtil.checkNull(retProcVal.get("O_RTN")).equals("TRUE")) {
	            strRtnMsg = LimsUtil.checkNull(retProcVal.get("O_MESSAGE"));
	         
	            // Rollback 처리 위해서 Exception 발생
	    		super.addOutVariable(mav, "fv_msg", "처리 시 오류가 발생되었습니다.");
	            //throw new BizException (strRtnMsg);
	        } else {
			
				//처리건수를 OutVariable에 설정한다.
				super.addOutVariable(mav, "fv_msg", "마이너스채권 상계처리 되었습니다.");
				//super.addOutVariable(mav, "fv_processCnt", processCnt);
			
	        }
        
		} else {

    		super.addOutVariable(mav, "fv_msg", "월마감되어 처리가 불가합니다.");
            //throw new BizException (strRtnMsg);
			
		}
	        
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 마이너스 상계(을)를 Delete 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("batchDelete.xdo")
	public ModelAndView batchDelete(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_search");
		
		//전표처리 확인 
		RecordSet rs = receiveMgntService.selectJcnt(param.get("ds_search").get(0));
        //RecordSet rs = receiveMgntService.selectBTList01(parameter);
		
		//처리된 내역이 있는 경우만 실행
		if (rs.get(0).get("pYn").equals("Y")) {
			//전표 건수가 있는 경우
			if (rs.get(0).get("jYn").equals("Y")) {
				//logger.debug("j : " + rs.get(0).get("jCnt"));    
				//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
				super.addOutVariable(mav, "fv_msg", "전표생성되어 취소가 불가합니다.");
			    // Rollback 처리 위해서 Exception 발생
	            //throw new BizException ("전표생성되어 취소가 불가합니다.");
				
			} else { 
				//삭제 처리한다.
				int processCnt = receiveMgntService.batchDelete(parameter);
	
				//처리건수를 OutVariable에 설정한다.
				super.addOutVariable(mav, "fv_processCnt", processCnt);
				super.addOutVariable(mav, "fv_msg", "마이너스채권 상계취소 되었습니다.");
			}
		} else {
			//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
			super.addOutVariable(mav, "fv_msg", "취소할 내용이 없습니다.");
			
		}
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");	

		
	}
	
	/**
	 * 플러스채권 자동대체(을)를 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("batchProc2.xdo")
	public ModelAndView batchProc2(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_search");
			
		Map<String, Object> rowData = parameter.get(0);
		
		String tm_cd = rowData.get("tmCd").toString();
		
	    Map<String, Object> retProcVal = new HashMap<String, Object>();

        /*
        P_MONTH             IN  VARCHAR2,     --기준월
        P_TM_CD               IN  VARCHAR2,   --팀(본부)
        P_CC_CD               IN  VARCHAR2,   --CC
        P_CUST_CD             IN  VARCHAR2,   --거래처
        */
        Map<String, Object> procParam = new HashMap<String, Object>();
        //logger.debug("P_MONTH : " + rowData.get("month"));      
        //logger.debug("P_TM_CD : " + "[" + tm_cd + "]");          
        procParam.put("P_MONTH", rowData.get("month"));
        //월마감 확인
		RecordSet rs = receiveMgntService.chkClose(param.get("ds_search").get(0));
        
		int tCnt = Integer.parseInt(rs.get(0).get("tCnt").toString());
        logger.debug("tCnt : " + "[" + tCnt + "]");        
		//영업&회계 월마감 된건이 0인 경우만 실행
		//if (rs.get(0).get("tCnt").equals("0")) {
		if (tCnt == 0) {       
	        
	        //if (!LimsUtil.checkNull(tm_cd).equals("TRUE")) {
	        if (!tm_cd.equals("")) {
	        	//팀코드 있는 경우
	        	procParam.put("P_TM_CD", rowData.get("tmCd"));
	        	procParam.put("P_CC_CD", rowData.get("ccCd"));
	        	procParam.put("P_CUST_CD", rowData.get("custCd"));   
	        	procParam.put("P_USER", "SYSTEM-ST2");         
	        	
	            retProcVal = receiveMgntDAO.batchst2Pro(procParam);   	
	        } else {
	        	//팀코드 없는 경우
	        	procParam.put("P_TM_CD", rowData.get("tmCd"));
	        	procParam.put("P_CC_CD", rowData.get("ccCd"));    
	        	procParam.put("P_CUST_CD", rowData.get("custCd"));    
	        	procParam.put("P_USER", "SYSTEM-ST2");           	
	        	
	            retProcVal = receiveMgntDAO.batchst2aPro(procParam);
	        }
	        
	        // 로그를 쌓는다.
	        String strRtnMsg = "";   
	        logger.debug("O_RTN : " + retProcVal.get("O_RTN"));             
	        logger.debug("O_RTNMSG : " + retProcVal.get("O_MESSAGE"));          
	        if (!LimsUtil.checkNull(retProcVal.get("O_RTN")).equals("TRUE")) {
	            strRtnMsg = LimsUtil.checkNull(retProcVal.get("O_MESSAGE"));
	         
	            // Rollback 처리 위해서 Exception 발생
	    		super.addOutVariable(mav, "fv_msg", "처리 시 오류가 발생되었습니다.");
	            //throw new BizException (strRtnMsg);
	        } else {
			
				//처리건수를 OutVariable에 설정한다.
				super.addOutVariable(mav, "fv_msg", "플러스채권 대체처리 되었습니다.");
				//super.addOutVariable(mav, "fv_processCnt", processCnt);
			
	        }
        
		} else {

    		super.addOutVariable(mav, "fv_msg", "월마감되어 처리가 불가합니다.");
            //throw new BizException (strRtnMsg);
			
		}
	        
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 플러스채권 대체(을)를 Delete 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("batchDelete2.xdo")
	public ModelAndView batchDelete2(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_search");
		
		//전표처리 확인 
		RecordSet rs = receiveMgntService.selectJcnt2(param.get("ds_search").get(0));
        //RecordSet rs = receiveMgntService.selectBTList01(parameter);
		
		//처리된 내역이 있는 경우만 실행
		if (rs.get(0).get("pYn").equals("Y")) {
			//전표 건수가 있는 경우
			if (rs.get(0).get("jYn").equals("Y")) {
				//logger.debug("j : " + rs.get(0).get("jCnt"));    
				//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
				super.addOutVariable(mav, "fv_msg", "전표생성되어 취소가 불가합니다.");
			    // Rollback 처리 위해서 Exception 발생
	            //throw new BizException ("전표생성되어 취소가 불가합니다.");
				
			} else { 
				//삭제 처리한다.
				int processCnt = receiveMgntService.batchDelete2(parameter);
	
				//처리건수를 OutVariable에 설정한다.
				super.addOutVariable(mav, "fv_processCnt", processCnt);
				super.addOutVariable(mav, "fv_msg", "플러스채권 대체취소 되었습니다.");
			}
		} else {
			//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
			super.addOutVariable(mav, "fv_msg", "취소할 내용이 없습니다.");
			
		}
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");	

		
	}
	
}

