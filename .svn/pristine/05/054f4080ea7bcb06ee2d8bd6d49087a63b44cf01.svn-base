package com.hwfs.fs.fsm.web;

import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.batch.defaults.DefaultBatchController;
import com.hwfs.batch.launch.BatchRunner;
import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.util.SessionUtil;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.sc.cmn.dto.LoginDTO;

/**
 * Batch Job 실행 Sample Controller
 * @ClassName BatchRunSampleController.java
 * @Description BatchRunSampleController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2014. 12. 19.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2014. 12. 19.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
public class StandardPriceUpdateController extends DefaultBatchController {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/**
	 * DB to DB 처리 예(Async 처리)
	 * 
	 * @param xpDto
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="fs/fsm/runStandardPriceUpdate.xdo")
    public ModelAndView runStandardPriceUpdate(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest req) throws Exception {
		
		String jobName = "fsiStdPriceUpdateProJob";
		
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = createModelAndView();

		//logger.debug("baseDd : " + LimsUtil.checkNull(req.getAttribute("baseDd")));
		
		// 로그인 세션 정보 얻기
		LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(req);

		Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		logger.debug("baseDd : " + LimsUtil.checkNull(inVar.get("baseDd")));
		
		String baseDd = LimsUtil.checkNull(inVar.get("baseDd"));

		//배치를 실행시킨다.
		Map<String, Object> batchRunInfo = super.batchRunAsync(jobName, getUniqueJobParameters(baseDd, false), loginDTO.getSabun());
		
		logger.debug ("runBatchDBToDB={}", batchRunInfo);
		
		//실행결과를 확인한다.
		if (successBatch (batchRunInfo))
			return setResultSet (mav, DefaultConsts.OK_CODE, "");
		else
			return setResultSet (mav, DefaultConsts.ERR_CODE, getBatchErrMsg(batchRunInfo));
		
	}

	//임시 개발을 위한 테스트용
	protected String getUniqueJobParameters(String baseDd, boolean isSync) {		
		BatchRunner batchRunner = getBatchRunner (isSync);
		String paramters = batchRunner.createUniqueJobParameters();

		paramters = batchRunner.addJobParameter(paramters, "baseDd", baseDd);

		return paramters;
	}

}
