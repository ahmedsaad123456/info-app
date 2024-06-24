const BASE_URL = 'https://$BASE_DOMEN/api';

const BASE_DOMEN = 'api.neurosubconscious.ru';

const BASE_URL_AVATAR = 'https://$BASE_DOMEN/avatars/';
const BASE_URL_PREVIEW = 'https://$BASE_DOMEN/previews/';

String PUBLIC = BASE_DOMEN.split('.').last == "ai"
    ? "https://neurosubconscious.ai/public/public.html"
    : "http://neurosubconscious.ru/public/public.html";

late String? token;
