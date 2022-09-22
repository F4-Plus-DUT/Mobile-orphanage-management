import 'package:orphanage_management_system/models/Category.dart';

class CategoryService {
  static List<Category> getAllCatories() {
    return [
      Category(
          name: 'Account',
          title: 'Account',
          subtitle: '',
          image: 'images/account.png'),
      Category(
          name: 'Children',
          title: 'Children',
          subtitle: '',
          image: 'images/children.png'),
      Category(
          name: 'Staff',
          title: 'Staff',
          subtitle: '',
          image: 'images/staff.png'),
      Category(
          name: 'Activity',
          title: 'Activities',
          subtitle: 'Donation, Valuntary',
          image: 'images/activity.png'),
      Category(
          name: 'Event',
          title: 'Events',
          subtitle: 'Funny, Picnic',
          image: 'images/event.png'),
      Category(
          name: 'Adoption and Introduction',
          title: 'Children Activity',
          subtitle: 'Adoption, Introduction',
          image: 'images/adoption.png'),
      Category(
          name: 'Statistic',
          title: 'Statistic',
          subtitle: '',
          image: 'images/statistic.png')
    ];
  }
}
