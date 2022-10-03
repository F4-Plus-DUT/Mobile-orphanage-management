import 'package:orphanage_management_system/models/category.dart';

class CategoryService {
  static List<Category> getAllCatories() {
    return [
      Category(
          name: 'Account',
          title: 'Account',
          subtitle: '',
          image: 'images/account.png',
          page: ''),
      Category(
          name: 'Children',
          title: 'Children',
          subtitle: '',
          image: 'images/children.png',
          page: '/children_item'),
      Category(
          name: 'Staff',
          title: 'Staff',
          subtitle: '',
          image: 'images/staff.png',
          page: ''),
      Category(
          name: 'Activity',
          title: 'Activities',
          subtitle: 'Donation, Valuntary',
          image: 'images/activity.png',
          page: ''),
      Category(
          name: 'Event',
          title: 'Events',
          subtitle: 'Funny, Picnic',
          image: 'images/event.png',
          page: ''),
      Category(
          name: 'Adoption and Introduction',
          title: 'Children Activity',
          subtitle: 'Adoption, Introduction',
          image: 'images/adoption.png',
          page: ''),
      Category(
          name: 'Statistic',
          title: 'Statistic',
          subtitle: '',
          image: 'images/statistic.png',
          page: '')
    ];
  }
}
