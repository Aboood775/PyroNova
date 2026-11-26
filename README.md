# PyroNova

**AI-powered fire safety insights from microgravity combustion data.**
NASA Space Apps Challenge Cairo 2026, challenge *Flame in Freefall*.

A fire in space behaves differently from a fire on Earth. PyroNova turns NASA microgravity combustion
research into fire-safety support for two users: **engineers before the mission** (web dashboard) and
**astronauts during an emergency** (mobile app).

## Videos

[![PyroNova | NASA Space Apps Cairo 2026 | Flame in Freefall](https://img.youtube.com/vi/HsP8Qnx5H2g/hqdefault.jpg)](https://www.youtube.com/watch?v=HsP8Qnx5H2g)

- [Project video: PyroNova, NASA Space Apps Cairo 2026](https://www.youtube.com/watch?v=HsP8Qnx5H2g)

## Repository layout

| Folder | What it is | Stack |
|---|---|---|
| [`mobile/`](mobile) | Astronaut emergency app: module-wide fire alert (siren + SOS vibration), step-by-step protocol with read-aloud, AI research assistant by text or voice, NASA research archive on Home | Kotlin, Jetpack Compose, MVVM, Retrofit/OkHttp, Firebase Cloud Messaging, Android TTS/SpeechRecognizer |
| [`frontend/`](frontend) | Web dashboard for engineers: experiments explorer, AI chat with sources, safety guidelines | Next.js, React, TypeScript, Tailwind CSS |
| [`backend/`](backend) | REST API: auth with email OTP, chats, AI proxy (`/ask`), emergency guide, fire simulation push | Laravel (PHP), Sanctum, Firebase Admin, deployed on Vercel |
| [`ai/`](ai) | Research assistant: retrieval-augmented generation over NASA experiments plus a fire-prediction model | Python, RAG, embeddings, OpenRouter LLMs, scikit-learn |
| [`data-engineering/`](data-engineering) | Cleaned NASA PSI data: experiments database, seed files, RAG documents, dashboard JSON | SQLite / MySQL seeds, CSV, JSON |

## Data source

NASA Physical Sciences Informatics (PSI), <https://psi.nasa.gov>: PSI-159 (ACME CFI-G) gaseous-flame tests,
SAFFIRE-III, BASS/BASS-II and the related investigations and publications. This is archived research data,
not live spacecraft telemetry. ML predictions are research/educational output, not certified fire-safety guidance.

## Running each part

- **Mobile:** open `mobile/` in Android Studio. Add your own `app/google-services.json` (Firebase) for push
  notifications. Optional `local.properties` keys: `flame.baseUrl`, `flame.useFake=true` (offline demo).
- **Frontend:** `cd frontend && npm install && npm run dev`.
- **Backend:** `cd backend && composer install && cp .env.example .env && php artisan key:generate`, then set
  the database, mail and Firebase credentials in `.env` (never commit them).
- **AI:** see `ai/README.md`. Set `OPENROUTER_API_KEY` in `ai/rag/.env`.

## Team

Built by the PyroNova team (mobile, web, backend, AI and data engineering tracks) for NASA Space Apps Cairo 2026.
