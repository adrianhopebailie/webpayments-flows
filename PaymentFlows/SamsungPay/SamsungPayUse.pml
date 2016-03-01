@startuml
!includeurl https://raw.githubusercontent.com/w3c/webpayments-flows/gh-pages/PaymentFlows/skin.ipml

title Using SamsungPay (unofficial)

participant User as U
participant "SamsungPay App" as SPA
participant "SamsungPay Server" as SPS
participant "Store / POS" as S
participant "Card Issuer" as CI

U->S: choose goods
S->U: show bill
U->SPA: launch SamsungPay App
SPA->SPA: select cardtype
SPA->SPA: user authentication \nwith fingerprint
SPA->SPA: generate One Time Token ("Cryptogram") \n(either with static or dynamic Token, \nand time-based seed)
SPA->S: send OTT via MST or NFC
SPA<->SPS: store payment history
S<->CI: get card approval with OTT
S->U: show payment result
opt
U->S: sign on receipt
end
S->U: deliver goods

@enduml
