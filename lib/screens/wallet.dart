import 'dart:async';
import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';
import 'package:extended_list/extended_list.dart';
import 'package:minsk8/import.dart';

class WalletScreen extends StatefulWidget {
  static WalletData sourceList;

  @override
  WalletScreenState createState() {
    return WalletScreenState();
  }
}

class WalletScreenState extends State<WalletScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Движение Кармы'),
      ),
      body: PullToRefreshNotification(
        onRefresh: _onRefresh,
        maxDragOffset: kMaxDragOffset,
        child: Stack(
          children: [
            LoadingMoreCustomScrollView(
              rebuildCustomScrollView: true,
              // in case list is not full screen and remove ios Bouncing
              physics: AlwaysScrollableClampingScrollPhysics(),
              slivers: [
                LoadingMoreSliverList(SliverListConfig<WalletItem>(
                  extendedListDelegate: ExtendedListDelegate(
                    collectGarbage: (List<int> garbages) {
                      garbages.forEach((index) {
                        final unit =
                            WalletScreen.sourceList[index].payment?.unit;
                        if (unit == null) return;
                        final image = unit.images[0];
                        final provider = ExtendedNetworkImageProvider(
                          image.getDummyUrl(unit.id),
                        );
                        provider.evict();
                      });
                    },
                  ),
                  itemBuilder:
                      (BuildContext context, WalletItem item, int index) {
                    if (item.displayDate != null) {
                      return Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(8),
                        child: Container(
                          child: Text(
                            item.displayDate,
                            style: TextStyle(
                              fontSize: kFontSize,
                              fontWeight: FontWeight.w600,
                              color: Colors.black.withOpacity(0.8),
                            ),
                          ),
                          padding:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.all(
                              Radius.circular(kFontSize),
                            ),
                          ),
                        ),
                      );
                    }
                    final payment = item.payment;
                    var textData = {
                      AccountValue.start:
                          'Добро пожаловать! Ловите {{value}} Кармы для старта - пригодятся. Отдайте что-нибудь ненужное, чтобы забирать самые лучшие лоты. Не ждите! Добавьте первый лот прямо сейчас!',
                      AccountValue.invite:
                          'Получено {{value}} Кармы за приглашение участника {{member}}. Приглашайте ещё друзей!',
                      AccountValue.unfreeze: [
                        'Разморожено {{value}} Кармы. Желаем найти что-нибудь интересное!',
                        'Разморожено {{value}} Кармы. Желаем найти что-нибудь хорошее! 😊',
                        'Разморожено {{value}} Кармы. Нажмите "Добавить в ожидание" на лоте, чтобы получать уведомления о появлении похожих!',
                      ],
                      AccountValue.freeze:
                          'Ставка на лот принята! Заморожено {{value}} Кармы. Она будет разморожена по окончанию таймера или при отказе от лота. Удачи!',
                      AccountValue.limit:
                          'Заявка на лот принята. Доступно заявок на лоты "Даром" — {{limit}} в день. Осталось сегодня — {{value}}. Чтобы увеличить лимит — повысь Карму: что-нибудь отдай или пригласи друзей.',
                      AccountValue.profit:
                          'Получено {{value}} Кармы за лот. Отдайте ещё что-нибудь ненужное!',
                    }[payment.account];
                    if (textData is List) {
                      var textVariant = payment.textVariant;
                      if (textVariant == null ||
                          textVariant >= (textData as List).length) {
                        textVariant = 0;
                      }
                      textData = (textData as List)[textVariant];
                    }
                    Widget image;
                    String text = textData;
                    <AccountValue, Function>{
                      AccountValue.start: () {
                        // TODO: поменять на иконку приложения
                        image = Icon(
                          FontAwesomeIcons.gift,
                          color: Colors.deepOrangeAccent,
                        );
                        text = interpolate(text, params: {
                          'value': payment.value,
                        });
                      },
                      AccountValue.invite: () {
                        image = AspectRatio(
                          aspectRatio: 1,
                          child: ExtendedImage.network(
                            payment.invitedMember.avatarUrl,
                            fit: BoxFit.cover,
                            shape: BoxShape.circle,
                            enableLoadState: false,
                          ),
                        );
                        text = interpolate(text, params: {
                          'value': payment.value,
                          'member': payment.invitedMember.nickname,
                        });
                      },
                      AccountValue.unfreeze: () {
                        image = _getUnitImage(payment.unit);
                        text = interpolate(text, params: {
                          'value': payment.value,
                        });
                      },
                      AccountValue.freeze: () {
                        image = _getUnitImage(payment.unit);
                        text = interpolate(text, params: {
                          'value': payment.value,
                        });
                      },
                      AccountValue.limit: () {
                        image = _getUnitImage(payment.unit);
                        text = interpolate(text, params: {
                          'value': payment.value,
                          'limit': 7,
                        });
                      },
                      AccountValue.profit: () {
                        image = _getUnitImage(payment.unit);
                        text = interpolate(text, params: {
                          'value': payment.value,
                        });
                      },
                    }[payment.account]();
                    // TODO: InkWell
                    return ListTile(
                      leading: CircleAvatar(
                        child: image,
                        backgroundColor: Colors.white,
                      ),
                      title: Text(text),
                      subtitle: Text(
                        DateFormat.jm('ru_RU').format(
                          payment.createdAt.toLocal(),
                        ),
                      ),
                      dense: true,
                    );
                  },
                  sourceList: WalletScreen.sourceList,
                  indicatorBuilder: (
                    BuildContext context,
                    IndicatorStatus status,
                  ) {
                    return buildListIndicator(
                      context: context,
                      status: status,
                      sourceList: WalletScreen.sourceList,
                    );
                  },
                  lastChildLayoutType: LastChildLayoutType.foot,
                ))
              ],
            ),
            PullToRefreshContainer((PullToRefreshScrollNotificationInfo info) {
              final offset = info?.dragOffset ?? 0.0;
              return Positioned(
                top: offset - kToolbarHeight,
                left: 0,
                right: 0,
                child: Center(child: info?.refreshWiget),
              );
            }),
          ],
        ),
      ),
    );
  }

  Future<bool> _onRefresh() async {
    final sourceList = WalletScreen.sourceList;
    return await sourceList.handleRefresh();
  }

  Widget _getUnitImage(UnitModel unit) {
    return AspectRatio(
      aspectRatio: 1,
      child: ExtendedImage.network(
        unit.images[0].getDummyUrl(unit.id),
        fit: BoxFit.cover,
        shape: BoxShape.circle,
        enableLoadState: false,
      ),
    );
  }
}
