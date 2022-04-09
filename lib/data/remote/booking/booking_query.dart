class BookingQuery {
  static const String hotelBookingInformation = r'''
    query HotelBookingInformation($filter: HotelierHotelBookingInformationFilter) {
      hotelBookingInformation(filter: $filter) {
        count
        totalPage
        data {
          ... on Booking {
            id
            status
            checkinDate
            arrivalTime
            totalBaseAmount
            totalDiscountAmount
            totalTaxAmount
            totalServiceFeeAmount
            totalGrossAmount
            totalRefundAmount
            createdDate
            bookingNumber
            specialRequest
            pricePaymentNow
            balance
            promoCode
            note
            hotelReservationList {
              id
              reservationNumber
              baseAmount
              grossAmount
              discountAmount
              pricePaymentNow
              balance
              status
              checkinDate
              specialRequest
              reservationGuest {
                id
                emailAddress
                firstName
                lastName
                phoneNumber
              }
              hotelReservationPackage {
                id
                reservationId
                packageCode
                packageName
                packageImgId
                packageDetails
                packageRoomTypeId
                packageTermAndCondition
                packageHotelCxlPolicyCode
                packageTimeslotName
                packageTimeslotStartHour
                packageTimeslotEndHour
                packageTimeslotStartMinute
                packageTimeslotEndMinute
                packageTimeslotStartTime
                packageTimeslotEndTime
                packageBasePrice
              }
            }
            guest {
              firstName
              lastName
              isReturningGuest
              phoneNumber
              emailAddress
            }
          }
        }
      }
    }
  ''';
}
