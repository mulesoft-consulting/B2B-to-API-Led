%dw 1.0
%type tobd = :number { class: "java.math.BigDecimal" }
%output application/java
---
{
	TransactionSets: {
		v005010: {
			"850": [{
				Name: payload.PurchaseOrder.Address.Name,
				Heading: {
					"0200_BEG": {
						BEG01: "00",
						BEG02: "NE",
						BEG03: payload.PurchaseOrder.@PurchaseOrderNumber as :string {format: "##" },
						BEG05: payload.PurchaseOrder.@OrderDate as :date
					}
					//"3100_N1_Loop": [{
					//	"3400_N4": [{
					//		N401: payload.PurchaseOrder.Address.City,
					//		N402: payload.PurchaseOrder.Address.State,
					//		N403: payload.PurchaseOrder.Address.Zip,
					//		N404: payload.PurchaseOrder.Address.Country
					//	}]
					//}]
				},
				Detail: {
					"0100_PO1_Loop":  ( payload.PurchaseOrder.Items.*Item map {
						"0100_PO1": {
							PO102: $.Quantity as :tobd,
							PO104: $.USPrice as :tobd,
							PO107: $.@PartNumber
						}
					} )
				},
				Summary: {
					"0100_CTT_Loop": {
						"0200_AMT": {
							AMT01: "TT",
							AMT02: payload.PurchaseOrder.TotalPrice as :tobd
						}
					}
				}
			}]
		}
	}
}