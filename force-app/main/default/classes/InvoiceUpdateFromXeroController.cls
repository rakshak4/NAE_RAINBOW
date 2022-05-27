/**
 * Controller for InvoiceUpdateFromXero page.
 * 
 * @author Logan More
 * @created July 2013
 * @modified July 2013
 * @testclass InvoiceUpdateFromXeroControllerTest
 */
public with sharing class InvoiceUpdateFromXeroController {

	private ApexPages.StandardController controller;

	public InvoiceUpdateFromXeroController(ApexPages.StandardController controller) {

		this.controller = controller;
	}

	public PageReference doUpdate() {

		try {
			InvoiceUpdateFromXeroLogic.updateSingleInvoice(controller.getId());
			return new PageReference('/' + controller.getId());
		}
		catch (Exception e) {
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
			return null;
		}
	}
}