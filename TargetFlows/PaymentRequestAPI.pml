@startuml
!includeurl https://raw.githubusercontent.com/w3c/webpayments-flows/gh-pages/PaymentFlows/skin.ipml

participant "Payee Payment Provider" as MPSP
Participant "Payee Website" as Payee
participant "Payer's (Shopper's) Browser" as UA
Actor "Payer" as Payer
participant "Payment App" as PSPUI
participant "Payer Payment Provider" as CPSP

note over Payee, PSPUI: HTTPS

title Generic Payment Request API Flow V1

== Payment Request ==

Payee->UA: PaymentRequest (Items, Amounts, Shipping Options )
note right #aqua: PaymentRequest.Show() 
opt
	Payer<-[#green]>UA: Select Shipping Options
	UA->Payee: Shipping Info
	note right #aqua: shippingoptionchange or shippingaddresschange events
	Payee->UA: Revised PaymentRequest
	note right #aqua: PaymentRequestUpdateEvent.updateWith()
end

Payer<-[#green]>UA: Select Payment App/Instrument

create PSPUI
UA<-[#green]>PSPUI: Invoke Payment App

UA->PSPUI: PaymentRequest (- Options)

Payer<-[#green]>PSPUI: Authorise

Group Method specific processing
	PSPUI<->CPSP: interaction(s)
		note left
		(e.g. Authorise Payment
		/ Tokenise Payment Instrument)
		end note
end

PSPUI->UA: Payment App Response

== Payment Processing ==

UA-\Payee: Payment App Response

Note Right #aqua: Show() Promise Resolves

opt
	Payee-\MPSP: Finalise Payment
	MPSP-/Payee: Payment Response
end
	
== Notification ==

Payee->UA: Payment Completetion Status

note over UA #aqua: response.complete(status)

note over UA: UI removed

note over UA #aqua: complete promise resolves

@enduml