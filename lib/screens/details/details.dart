import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/controller/booking_controller.dart';
import 'package:user/controller/booking_list_controller.dart';
import 'package:user/controller/favourite_controller.dart';
import 'package:user/model/property_card_model.dart';
import 'package:user/screens/details/blocks/about_property_card.dart';
import 'package:user/screens/details/blocks/additional_details.dart';
import 'package:user/screens/details/blocks/construction_status_card.dart';
import 'package:user/screens/details/blocks/food_availability.dart';
import 'package:user/screens/details/blocks/location_section.dart';
import 'package:user/screens/details/blocks/property_header_card.dart';
import 'package:user/screens/details/blocks/property_sliver_appbar.dart';
import 'package:user/screens/details/widgets/aminitie_widget.dart';
import 'package:user/screens/details/widgets/bottom_button_cancel.dart';
import 'package:user/screens/details/widgets/bottom_buttons.dart';
import 'package:user/screens/details/widgets/build_white_card.dart';
import 'package:user/screens/details/widgets/buildowner_widget.dart';
import 'package:user/screens/details/widgets/location_widget.dart';
import 'package:user/screens/utils/app_color.dart';

class Details extends StatelessWidget {
  final Property property;

  // ✅ Use existing FavoritesController (per-user favorites)
  final FavoritesController favController = Get.find<FavoritesController>();

  // You can keep this as put or also use Get.find if already initialized
  final BookingController bookingController = Get.put(BookingController());
  final BookingListController bookingListController = Get.put(BookingListController());

  Details({super.key, required this.property});

  bool get isUnavailable =>
      property.status.toString().trim().toLowerCase() == '2' ||
      property.status.toString().trim().toLowerCase() == 'unavailable';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bg,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // 🔺 AppBar with favourite (heart) control
            PropertySliverAppBar(
              property: property,
              favController: favController,
            ),

            SliverToBoxAdapter(
              child: Container(
                color: AppColor.bg,
                child: Column(
                  children: [
                    PropertyHeaderCard(property: property),

                    AboutPropertyCard(about: property.about),

                    AdditionalDetails(
                      bedrooms: property.bedrooms,
                      bathrooms: property.bathrooms,
                      powerBackup: property.powerbackup,
                      furnished: property.furnished,
                    ),

                    if (property.collectiontype == 'sell_property')
                      ConstructionStatusCard(
                        status: property.constructionstatus,
                      ),

                    if (property.collectiontype == 'pg_property')
                      FoodAvailability(food: property.food),

                    buildWhiteCard(
                      title: 'Amenities',
                      child: AmenitiesWidget(property: property),
                    ),

                    LocationSection(
                      location: property.location,
                      locationCard: buildLocationCard(property),
                    ),

                    buildWhiteCard(
                      title: 'Contact Owner',
                      child: buildOwnerSection(property.userId),
                    ),

                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // 🔻 Booking bottom bar
   bottomNavigationBar: Obx(() {
  final booking = bookingListController.getBookingByPropertyId(property.id);

  final bookingStatus =
      property.bookingstatus.toLowerCase();

  if (bookingStatus == 'booked' && booking != null) {
    return bottomButtonCancel(
      context,
      property,
      bookingId: booking.id,
    );
  }

  return bottomButtons(property);
}),

    );
  }
}
