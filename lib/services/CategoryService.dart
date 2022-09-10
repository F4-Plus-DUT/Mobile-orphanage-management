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
          title: 'Donate, Valuntary Activities',
          subtitle: '',
          image: 'images/activity.png'),
      Category(
          name: 'Event',
          title: 'Funny, Picnic events',
          subtitle: '',
          image: 'images/event.png'),
      Category(
          name: 'Adoption and Introduction',
          title: 'Children Adoption and Introduction',
          subtitle: '',
          image: 'images/adoption.png'),
      Category(
          name: 'Statistic',
          title: 'Statistic',
          subtitle: '',
          image: 'images/statistic.png')
    ];
  }
}
