import 'package:flutter/material.dart';
import 'package:info_app/core/customs/public.dart';

const BASE_URL = 'https://$BASE_DOMEN/api';

const BASE_DOMEN = 'api.neurosubconscious.ru';

const BASE_URL_AVATAR = 'https://$BASE_DOMEN/avatars/';
const BASE_URL_PREVIEW = 'https://$BASE_DOMEN/previews/';

String PUBLIC = BASE_DOMEN.split('.').last == "ai"
    ? "https://neurosubconscious.ai/public/public.html"
    : "https://neurosubconscious.ru/public/public.html";

late String? token;
void openUrl(context) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const PublicWidget()));
}
